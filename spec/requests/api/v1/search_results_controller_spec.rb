require 'rails_helper'

RSpec.describe SearchTasksController, type: :request do
  let!(:search_result) { create(:search_result, url: 'www.amazon.com') }
  let!(:search_result2) { create(:search_result, search_report: search_report, url: 'www.amazon.com/electronics') }
  let!(:search_result3) { create(:search_result, search_report: search_report, url: 'www.wikipedia.com') }
  let(:search_task) { search_result.search_task }
  let(:search_report) { search_result.search_report }
  let(:user) { search_task.user }
  let(:token_params) { { access_token: user.access_tokens.last.token } }

  describe '#index' do
    let(:json_response) {
      {'data'=>[{'id'=>search_task.id.to_s, 'type'=>'search-tasks',
       'attributes'=>{'created-at'=>search_task.created_at.to_s(:long), 'name'=>search_task.name, 'state'=>search_task.state },
       'relationships'=>{'search-reports'=>{'data'=>[{'id'=>search_report.id.to_s, 'type'=>'search-reports'}]},
       'search-results'=>{'data'=>[{'id'=>search_result.id.to_s, 'type'=>'search-results'}, {'id'=>search_result2.id.to_s,
       'type'=>'search-results'}]}}}], 'included'=>[{'id'=>search_report.id.to_s, 'type'=>'search-reports',
       'attributes'=>{'keyword'=>'holiday', 'result-stats'=>nil, 'search-task-id'=>search_task.id}},
       {'id'=>search_result.id.to_s, 'type'=>'search-results', 'attributes'=>{'url'=>search_result.url,
        'result-type'=>search_result.result_type, 'search-report-id'=>search_report.id}},
       {'id'=>search_result2.id.to_s, 'type'=>'search-results', 'attributes'=>{'url'=>search_result2.url,
        'result-type'=>search_result2.result_type, 'search-report-id'=>search_report.id}}]
      }
    }

    def send_request(params={})
      get '/api/v1/search_results', params: params.merge(token_params)
    end

    before { send_request(q: { url_cont: 'amazon' }) }

    it { expect(JSON.parse(response.body)).to eq(json_response) }
    it  { expect(response.status).to be(200) }
  end

end

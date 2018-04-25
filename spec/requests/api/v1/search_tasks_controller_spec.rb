require 'rails_helper'

RSpec.describe SearchTasksController, type: :request do
  let(:search_result) { create(:search_result) }
  let(:search_task) { search_result.search_task }
  let(:search_report) { search_result.search_report }
  let(:user) { search_task.user }

  let(:token_params) { { access_token: user.access_tokens.last.token } }

  describe '#index' do
    before { search_result }
    let(:json_response) {
      { 'data'=>[{'id'=> search_task.id.to_s, 'type'=> 'search-tasks', 'attributes'=>{'created-at'=>search_task.created_at.to_s(:long),
        'name'=> search_task.name, 'state'=> search_task.state}, 'relationships'=>{'search-reports'=>{'data'=>[]},
        'search-results'=>{'data'=>[]}}}] }
    }

    def send_request
      get '/api/v1/search_tasks', params: token_params
    end

    before { send_request }
    it { expect(JSON.parse(response.body)).to eq(json_response) }
    it { expect(response.status).to be(200) }
  end

  describe '#show' do
    before { search_result }
    let(:json_response) {
      {'data'=>{'id'=>search_task.id.to_s, 'type'=>'search-tasks', 'attributes'=>{'created-at'=>search_task.created_at.to_s(:long),
       'name'=>'test_name', 'state'=>search_task.state}, 'relationships'=>{'search-reports'=>{'data'=>[{'id'=>search_report.id.to_s,
        'type'=>'search-reports'}]}, 'search-results'=>{'data'=>[{'id'=>search_result.id.to_s, 'type'=>'search-results'}]}}},
        'included'=>[{'id'=>search_report.id.to_s, 'type'=>'search-reports', 'attributes'=>{'keyword'=>search_report.keyword, 'result-stats'=>nil,
        'search-task-id'=>search_task.id}}, {'id'=>search_result.id.to_s, 'type'=>'search-results',
        'attributes'=>{'url'=>search_result.url, 'result-type'=>'regular', 'search-report-id'=>search_report.id}}]}
    }

    def send_request
      get "/api/v1/search_tasks/#{search_task.id}", params: token_params
    end

    before { send_request }
    it { expect(JSON.parse(response.body)).to eq(json_response) }
    it  { expect(response.status).to be(200) }
  end

  describe '#create' do
    let(:csv_file) { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'keywords.csv'), 'text/csv') }

    def send_request(params={})
      post '/api/v1/search_tasks/', params: params.merge(token_params)
    end

    context 'successfull creation' do
      before { send_request(search_task: { name: 'task_name2', keywords_csv: csv_file }) }
      it { expect(response.status).to be(200) }
      it { expect(SearchTask.last.name).to eq('task_name2') }
    end

    context 'unsuccessfull creation' do
      let(:json_error) { {'errors'=>[{'source'=>{'pointer'=>'/data/attributes/keywords-csv'}, 'detail'=>'Must be a csv file'}]} }
      before { send_request(search_task: { name: 'task_name2' }) }
      it { expect(response.status).to be(422) }
      it { expect(JSON.parse(response.body)).to eq(json_error) }
    end
  end

end

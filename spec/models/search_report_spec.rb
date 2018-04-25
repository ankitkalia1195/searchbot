require 'rails_helper'

RSpec.describe SearchReport do
  let(:search_report) { create(:search_report) }
  let(:google_search_parser) { GoogleSearchParser.new('new york tours') }
  let(:html_source) { File.read(Rails.root.join('spec', 'fixtures', 'files', 'google_search_results.html')).gsub(/[\\\"]/,"") }

  describe 'Associations' do
    it { is_expected.to belong_to(:search_task) }
    it { is_expected.to have_many(:search_results).dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:keyword) }
  end

  describe 'Ransackers' do
    describe 'total_ad_count' do
      before do
        search_report.result_stats ||= {}
        search_report.result_stats[:total_ad_count] = 4
        search_report.save!
      end
      it { expect(SearchReport.ransack(total_ad_count_eq: 4).result).to include(search_report) }
      it { expect(SearchReport.ransack(total_ad_count_eq: 5).result).to_not include(search_report) }
    end
  end

  describe 'process!' do
    before do
      allow_any_instance_of(GoogleSearchParser).to receive(:open).and_return(html_source)
      search_report.process!
    end

    it { expect(search_report.result_stats['top_ad_count']).to eq(google_search_parser.top_ad_urls.size) }
    it { expect(search_report.result_stats['bottom_ad_count']).to eq(google_search_parser.bottom_ad_urls.size) }
    it { expect(search_report.result_stats['all_links_count']).to eq(google_search_parser.all_links_count) }
    it { expect(search_report.result_stats['results_count']).to eq(google_search_parser.results_count) }
    it { expect(search_report.search_results.map(&:url)).to eq(google_search_parser.top_ad_urls + google_search_parser.regular_result_urls + google_search_parser.bottom_ad_urls) }
    it { expect(search_report.html).to eq(html_source) }
  end
end

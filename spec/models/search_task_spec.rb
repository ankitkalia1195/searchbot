require 'rails_helper'

RSpec.describe SearchTask do
  let(:search_report) { create(:search_report) }
  let(:search_task) { search_report.search_task }

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:search_reports).dependent(:destroy) }
    it { is_expected.to have_many(:search_results).through(:search_reports) }
  end

  describe 'Enums' do
    it { expect(SearchTask.states).to eq({'pending'=>0, 'processing'=>1, 'complete'=>2, 'failed'=>3}) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:state) }

    describe 'Name Uniqueness scoped to user_id' do
      before do
        user = search_task.user
        @new_task = user.search_tasks.build(name: search_task.name)
        @new_task.valid?
      end
      it { expect(@new_task.errors[:name]).to include('has already been taken') }
    end
  end

  describe 'process!' do
    before do
      search_task
      allow_any_instance_of(SearchReport).to receive(:process!).and_return(true)
      search_task.process!
      @search_report_keywords = search_task.search_reports.pluck(:keyword)
    end

    it { expect(SearchReport.all).to_not include(search_report) }
    it { expect(@search_report_keywords).to include('berlin tours') }
    it { expect(@search_report_keywords).to include('warsaw tours') }
    it { expect(@search_report_keywords).to include('krakow tours') }
    it { expect(search_task.state).to eq('complete') }
  end

  describe '#ensure_document_in_csv_format' do
    context 'attachment not present' do
      before do
        @new_search_task = SearchTask.new
        @new_search_task.valid?
      end
      it { expect(@new_search_task.errors[:keywords_csv]).to eq(['Must be a csv file']) }
    end

    context 'invalid file' do
      before do
        search_task.keywords_csv.attach(io: File.open(Rails.root.join('spec', 'factories', 'text', 'keywords.txt')), filename: 'keywords.txt', content_type: 'text/txt')
        search_task.valid?
      end
      it { expect(search_task.errors[:keywords_csv]).to include('Must be a csv file') }
    end
  end


end

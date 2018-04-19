require 'rails_helper'

RSpec.describe SearchResult do
  let(:search_result) { create(:search_result) }

  describe 'Associations' do
    it { is_expected.to belong_to(:search_report) }
  end

  describe 'Enums' do
    it { expect(SearchResult.result_types).to eq({'regular'=> 0, 'top_ad' => 1, 'bottom_ad'=> 2}) }
  end

  describe 'Delegations' do
    it { is_expected.to delegate_method(:keyword).to (:search_report) }
    it { is_expected.to delegate_method(:search_task).to (:search_report) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:result_type) }
  end

  describe '#ad?' do
    let(:search_result1) { create(:search_result, result_type: 'top_ad') }
    let(:search_result2) { create(:search_result, result_type: 'bottom_ad') }

    it { expect(search_result.ad?).to be_falsey }
    it { expect(search_result1.ad?).to be_truthy }
    it { expect(search_result2.ad?).to be_truthy }
  end

end

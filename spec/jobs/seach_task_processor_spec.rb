require 'rails_helper'

RSpec.describe ProcessSearchTaskJob do
  let(:search_task) { create(:search_task) }

  describe '#perform' do
    before { search_task }
    it { expect { ProcessSearchTaskJob.perform_now(search_task) }.to change { search_task.search_reports.count } }
  end
end

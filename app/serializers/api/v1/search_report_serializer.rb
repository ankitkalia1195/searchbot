module Api
  module V1
    class SearchReportSerializer < ApplicationSerializer
      attributes :keyword, :result_stats, :search_task_id
    end
  end
end

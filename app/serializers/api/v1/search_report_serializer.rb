module Api
  module V1
    class SearchReportSerializer < ApplicationSerializer
      attributes :keyword, :result_stats
      has_many :search_results
    end
  end
end

module V1
  class SearchReportSerailizer < ApplicationSerializer
    attributes :keyword, :result_stats
    has_many :search_results, serializer: SearchResultSerializer
  end
end

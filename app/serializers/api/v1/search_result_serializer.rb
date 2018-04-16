module V1
  class SearchResultSerailizer < ApplicationSerializer
    attributes :url, :result_type
    belongs_to :search_report, serailizer: SearchReportSerializer
  end
end

module Api
  module V1
    class SearchResultSerializer < ApplicationSerializer
      attributes :url, :result_type, :search_report_id
    end
  end
end

module Api
  module V1
    class SearchResultSerializer < ApplicationSerializer
      attributes :url, :result_type
      belongs_to :search_report
    end
  end
end

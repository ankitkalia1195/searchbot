module V1
  class SearchTaskSerailizer < ApplicationSerializer
    attributes :created_at, :name, :state
    has_many :search_reports, serializer: SearchReportSerializer
  end
end

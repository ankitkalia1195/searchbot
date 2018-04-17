module Api
  module V1
    class SearchTaskSerializer < ApplicationSerializer
      attributes :created_at, :name, :state
      has_many :search_reports
    end
  end
end

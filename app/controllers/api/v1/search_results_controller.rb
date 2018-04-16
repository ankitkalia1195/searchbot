module Api
  module V1
    class SearchResultsController < BaseController

      def index
        params[:q] ||= {}
        params[:q][:s] ||= 'search_report_id asc'
        @search_results = SearchResult.ransack(params[:q]).result.includes(search_report: :search_task)
        render json: @search_results, included: ['search_report', 'search_report.search_task']
      end

    end
  end
end

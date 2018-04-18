module Api
  module V1
    class SearchResultsController < BaseController

      def index
        params[:q] ||= {}
        params[:q][:search_report_search_task_user_id_eq] = current_resource_owner.id
        search_results = SearchResult.ransack(params[:q]).result.includes(search_report: :search_task)
        search_result_ids = search_results.map(&:id)
        search_report_ids = search_results.map(&:search_report_id).uniq
        search_tasks =  search_results.map(&:search_task).uniq
        render json: search_tasks, load_associations: true, search_report_ids: search_report_ids, search_result_ids: search_result_ids, include: ['search_reports', 'search_results']
      end

    end
  end
end

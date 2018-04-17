class SearchResultsController < ApplicationController

  def index
    params[:q] ||= {}
    params[:q][:s] ||= 'search_report_keyword asc'
    params[:q][:search_report_search_task_user_id_eq] = current_user.id
    @search = SearchResult.ransack(params[:q])
    @search_results = @search.result.includes(search_report: :search_task)
    @search_results_grouped_by_report = @search_results.group_by(&:search_report)
  end

end

class SearchResultsController < ApplicationController

  def index
    params[:q] ||= {}
    @search = SearchResult.ransack(params[:q])
    @search_results = @search.result.group('search_report_id').select('search_report_id, array_agg(url) as urls, array_agg(result_type) as result_types').includes(search_report: :search_task)
  end

end

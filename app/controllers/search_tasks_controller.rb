class SearchTasksController < ApplicationController

  before_action :load_search_task, only: :show

  def index
    @search_tasks = current_user.search_tasks
  end

  def new
    @search_task = SearchTask.new
  end

  def create
    @search_task = current_user.search_tasks.build(permitted_search_task_params)
    if @search_task.save
      redirect_to search_tasks_path
    else
      render :new
    end
  end

  def show
    @search_reports = @search_task.search_reports.order('keyword').includes(:search_results)
  end

  private

  def permitted_search_task_params
    params.require(:search_task).permit(:name, :keywords_csv)
  end

  def load_search_task
    @search_task = current_user.search_tasks.find_by(id: params[:id])
    redirect_to search_tasks_path unless @search_task.present?
  end

end

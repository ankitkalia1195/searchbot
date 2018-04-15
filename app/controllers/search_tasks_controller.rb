class SearchTasksController < ApplicationController

  before_action :load_search_task, only: :show

  def index
    @search_tasks = SearchTask.all
  end

  def new
    @search_task = SearchTask.new
  end

  def create
    @search_task = SearchTask.new(permitted_search_task_params)
    if @search_task.save
      redirect_to search_tasks_path
    else
      render :new
    end
  end

  private

  def permitted_search_task_params
    params.require(:search_task).permit(:name, :keywords_csv)
  end

  def load_search_task
    @search_task = SearchTask.find_by(id: params[:id])
    redirect_to search_task_path unless @search_task.present?
  end

end

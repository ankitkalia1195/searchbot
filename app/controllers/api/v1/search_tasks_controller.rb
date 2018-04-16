module Api
  module V1
    class SearchTasksController < BaseController

      before_action :load_search_task, only: :show

      def index
        @search_tasks = SearchTask.all
        render json: @search_tasks
      end

      def create
        @search_task = SearchTask.new(permitted_search_task_params)
        if @search_task.save
          render json: @search_task
        else
          render json: @search_task, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      def show
        render json: @search_task, included: ['search_reports', 'search_reports.search_results']
      end

      private

      def permitted_search_task_params
        params.require(:search_task).permit(:name, :keywords_csv)
      end

      def load_search_task
        @search_task = SearchTask.find_by(id: params[:id])
        head 404 unless @search_task.present?
      end

    end
  end
end

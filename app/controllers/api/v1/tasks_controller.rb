module Api
  module V1
    class TasksController < ApplicationController
      def index
        tasks = Task.all
        render json: tasks
      end

      def create
        task = Task.create!(task_params)
        render json: task
      end

      def update
        task = Task.find(id: params[:id])
        task.update!(task_params)
        render json: task
      end

      private

      def task_params
        params.require(:data).permit(attributes: [:title])
      end
    end
  end
end

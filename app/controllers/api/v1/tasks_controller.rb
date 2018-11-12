module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: %i[destroy update]

      def index
        tasks = Task.all
        render json: tasks
      end

      def create
        task = Task.create!(task_params)
        render json: task
      end

      def update
        attributes = task_params['attributes']
        tag_titles = attributes.delete('tags') || []

        tags = tag_titles.map { |title| Tag.find_by!(title: title) }

        @task.update!(attributes.merge(tags: tags))

        render json: @task
      end

      def destroy
        @task.destroy
        render json: @task
      end

      private

      def set_task
        @task = Task.find(params[:id])
      end

      def task_params
        params.require(:data).permit(attributes: [:title, tags: []])
      end
    end
  end
end

module Api
  module V1
    class TagsController < ApplicationController
      def index
        tags = Tag.all
        render json: tags
      end

      def create
        tag = Tag.create!(tag_params)
        render json: tag
      end

      def update
        tag = Tag.find(params[:id])
        tag.update!(tag_params)
        render json: tag
      end

      private

      def tag_params
        params.require(:data).permit(attributes: [:title])
      end
    end
  end
end

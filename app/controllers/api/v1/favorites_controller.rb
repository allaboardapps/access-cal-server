module Api
  module V1
    class FavoritesController < Api::V1::ApiController
      def create
        favorite = Favorite.create_with(create_params).find_or_create_by(user_id: params[:user_id], event_id: params[:event_id])
        render json: favorite, each_serializer: FavoriteSerializer, status: :created
      end

      def index
        favorites = Favorite.all
        render json: favorites, each_serializer: FavoriteSerializer, status: :ok
      end

      def show
        favorite = Favorite.find params[:id]
        render json: favorite, each_serializer: FavoriteSerializer, status: :ok
      end

      def update
        favorite = Favorite.find params[:id]
        favorite.update_attributes(update_params)
        render json: favorite, each_serializer: FavoriteSerializer, status: :accepted
      end

      def destroy
        favorite = Favorite.find params[:id]
        favorite.destroy
        render json: {}, status: :accepted
      end

      private

      def update_params
        params.permit(
          :user_id, :event_id,
          :archived, :test, :dummy
        )
      end

      def create_params
        params.permit(
          :user_id, :event_id,
          :archived, :test, :dummy
        )
      end
    end
  end
end

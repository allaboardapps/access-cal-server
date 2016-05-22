module Api
  module V1
    class GroupsController < Api::V1::ApiController
      def create
        group = Group.create(create_params)
        render json: group, each_serializer: GroupSerializer, status: :created
      end

      def index
        groups = Group.all
        render json: groups, each_serializer: GroupSerializer, status: :ok
      end

      def show
        group = Group.find_by(id: params[:id])
        render json: group, each_serializer: GroupSerializer, status: :ok
      end

      def update
        group = Group.find_by(id: params[:id])
        group.update(update_params)
        render json: group, each_serializer: GroupSerializer, status: :accepted
      end

      def destroy
        group = Group.find_by(destroy_params)
        group.destroy
        render json: {}, status: :accepted
      end

      private

      def update_params
        params.permit(
          :name, :group_type, :organization_id,
          :archived, :test, :dummy
        )
      end

      def create_params
        params.permit(
          :name, :group_type, :organization_id,
          :archived, :test, :dummy
        )
      end

      def destroy_params
        params.permit(
          :id
        )
      end
    end
  end
end

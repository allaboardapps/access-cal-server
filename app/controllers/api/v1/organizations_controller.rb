module Api
  module V1
    class OrganizationsController < Api::V1::ApiController
      def create
        organization = Organization.create(create_params)
        render json: organization, each_serializer: OrganizationSerializer, status: :created
      end

      def index
        organizations = Organization.all
        render json: organizations, each_serializer: OrganizationSerializer, status: :ok
      end

      def show
        organization = Organization.find_by(id: params[:id])
        render json: organization, each_serializer: OrganizationSerializer, status: :ok
      end

      def update
        organization = Organization.find_by(id: params[:id])
        organization.update(update_params)
        render json: organization, each_serializer: OrganizationSerializer, status: :accepted
      end

      def destroy
        organization = Organization.find_by(destroy_params)
        organization.destroy
        render json: {}, status: :accepted
      end

      private

      def update_params
        params.permit(
          :name,
          :archived, :test, :dummy
        )
      end

      def create_params
        params.permit(
          :name,
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

module Api
  module V1
    class CalendarUsersController < Api::V1::ApiController
      def create
        calendar_user = CalendarUser.find_or_create_by(create_params)
        render json: calendar_user, each_serializer: CalendarUserSerializer, status: :created
      end

      def destroy
        calendar_user = CalendarUser.find_by(id: params[:id])
        calendar_user.destroy
        render json: {}, status: :accepted
      end

      private

      def create_params
        params.permit(
          :calendar_id, :user_id, :role,
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

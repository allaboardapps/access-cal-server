class Api
  class V1
    class CalendarsController < Api::V1::ApiController
      def create
        calendar = Calendar.create(create_params)
        render json: calendar, each_serializer: CalendarSerializer, status: :created
      end

      def index
        calendars = Calendar.all
        render json: calendars, each_serializer: CalendarSerializer, status: :ok
      end

      def show
        calendar = Calendar.find params[:id]
        render json: calendar, each_serializer: CalendarSerializer, status: :ok
      end

      def update
        calendar = Calendar.find params[:id]
        calendar.update_attributes(update_params)
        render json: calendar, each_serializer: CalendarSerializer, status: :accepted
      end

      def destroy
        calendar = Calendar.find params[:id]
        calendar.destroy
        render json: {}, status: :accepted
      end

      private

      def update_params
        params.permit(
          :name, :time_zone, :abbreviation,
          :archived, :test, :dummy
        )
      end

      def create_params
        params.permit(
          :name, :time_zone, :abbreviation,
          :archived, :test, :dummy
        )
      end
    end
  end
end

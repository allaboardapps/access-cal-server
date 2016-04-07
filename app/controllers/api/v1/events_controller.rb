class Api::V1::EventsController < Api::V1::ApiController
  def create
    event = Event.create(create_params)
    render json: event, each_serializer: EventSerializer, status: :created
  end

  def index
    events = Event.all
    render json: events, each_serializer: EventSerializer, status: :ok
  end

  def show
    event = Event.find params[:id]
    render json: event, each_serializer: EventSerializer, status: :ok
  end

  def update
    event = Event.find params[:id]
    event.update_attributes(update_params)
    render json: event, each_serializer: EventSerializer, status: :accepted
  end

  def destroy
    event = Event.find params[:id]
    event.destroy
    render json: {}, status: :accepted
  end

  private

  def update_params
    params.permit(
      :author_id, :location_id, :name, :abbreviation,
      :starts_at, :ends_at, :description, :street_address, :secondary_address,
      :city, :state, :country, :zip_code, :time_zone, :latitude, :longitude, :admin_notes,
      :archived, :test
    )
  end

  def create_params
    params.permit(
      :author_id, :location_id, :name, :abbreviation,
      :starts_at, :ends_at, :description, :street_address, :secondary_address,
      :city, :state, :country, :zip_code, :time_zone, :latitude, :longitude, :admin_notes,
      :archived, :test
    )
  end
end

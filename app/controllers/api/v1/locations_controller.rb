class Api::V1::LocationsController < Api::V1::ApiController
  def create
    location = Location.create(create_params)
    render json: location, each_serializer: LocationSerializer, status: :created
  end

  def index
    locations = Location.all
    render json: locations, each_serializer: LocationSerializer, status: :ok
  end

  def show
    location = Location.find params[:id]
    render json: location, each_serializer: LocationSerializer, status: :ok
  end

  def update
    location = Location.find params[:id]
    location.update_attributes(update_params)
    render json: location, each_serializer: LocationSerializer, status: :accepted
  end

  def destroy
    location = Location.find params[:id]
    location.destroy
    render json: {}, status: :accepted
  end

  private

  def update_params
    params.permit(:region_id, :name, :abbreviation, :time_zone, :admin_notes, :archived, :test)
  end

  def create_params
    params.permit(:region_id, :name, :abbreviation, :time_zone, :admin_notes, :archived, :test)
  end
end

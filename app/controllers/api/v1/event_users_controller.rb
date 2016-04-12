class Api::V1::EventUsersController < Api::V1::ApiController
  def create
    event_user = EventUser.find_or_create_by(create_params)
    render json: event_user, each_serializer: EventUserSerializer, status: :created
  end

  def destroy
    event_user = EventUser.find_by(id: params[:id])
    event_user.destroy
    render json: {}, status: :accepted
  end

  private

  def create_params
    params.permit(
      :event_id, :user_id, :role, :archived, :test, :dummy
    )
  end

  def destroy_params
    params.permit(
      :id
    )
  end
end

class Api::V1::UsersController < Api::V1::ApiController
  def create
    user = User.create(create_params)
    user.confirm
    render json: {}, each_serializer: UserSerializer, status: :created
  end

  def index
    users = User.all
    render json: users, each_serializer: UserSerializer, status: :ok
  end

  def show
    user = User.find params[:id]
    render json: user, each_serializer: UserSerializer
  end

  def update
    user = User.find params[:id]
    user.update_attributes(update_params)
    render json: user, each_serializer: UserSerializer, status: :accepted
  end

  def destroy
    user = User.find params[:id]
    user.destroy
    render json: {}, status: :accepted
  end

  private

  def update_params
    params.permit(:first_name, :last_name, :email, :zip_code, :time_zone, :location_id, :roles, :statuses, :archived, :test, :admin_notes, :password, :password_confirmation)
  end

  def create_params
    params.permit(:first_name, :last_name, :email, :zip_code, :time_zone, :location_id, :roles, :statuses, :archived, :test, :admin_notes, :password, :password_confirmation)
  end
end

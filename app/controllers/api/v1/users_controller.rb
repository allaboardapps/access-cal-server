class Api::V1::UsersController < Api::V1::ApiController

  def show
    user = User.find params[:user_id]
    render json: user, each_serializer: UsersSerializer
  end

end

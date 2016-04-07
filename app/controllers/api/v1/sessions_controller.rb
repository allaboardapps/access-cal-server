class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_action :authenticate_user_from_token!, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]

  def create
    user = User.find_by(email: params[:email])

    respond_to do |format|
      if user && user.valid_password?(params[:password])
        user.generate_token! unless user.token
        format.json { render json: user, each_serializer: UserSerializer }
      else
        format.json { head :forbidden }
      end
    end
  end
end

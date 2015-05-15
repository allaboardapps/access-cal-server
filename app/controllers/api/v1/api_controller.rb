class Api::V1::ApiController < ApplicationController
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!
  respond_to :json

  private

  def authenticate_user_from_token!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
    user = User.find_by(email: options[:email])

    if user && Devise.secure_compare(user.token, token)
      sign_in(user, store: false)
    else
      render text: "Error: Not Authorized", status: 403 and return
    end
  end
end

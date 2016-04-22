class Api::V1::ApiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :paramter_missing
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  before_action :authenticate_user_from_token!
  before_action :authenticate_user!
  respond_to :json

  private

  def record_not_found
    render json: {
      errors: {
        id: 1,
        status: 404,
        title: "Record Not Found",
        detail: "Record not found based on provided arguments",
        params: "#{params.to_json}"
      }
    }, status: :not_found
  end

  def paramter_missing
    render json: {
      errors: {
        id: 1,
        status: 400,
        title: "Bad Request",
        detail: "Parameter missing",
        params: "#{params.to_json}"
      }
    }, status: :bad_request
  end

  def record_invalid
    render json: {
      errors: {
        id: 1,
        status: 400,
        title: "Bad Request",
        detail: "Record invalid",
        params: "#{params.to_json}"
      }
    }, status: :bad_request
  end

  def authenticate_user_from_token!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
    user = User.find_by(email: options[:email])

    if user && Devise.secure_compare(user.token, token)
      sign_in(user, store: false)
    else
      render text: "Error: Not Authorized", status: 403
    end
  end
end

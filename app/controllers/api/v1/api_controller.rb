class Api
  class V1
    class ApiController < ApplicationController
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
            request_params: params
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
            request_params: params
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
            request_params: params
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
  end
end

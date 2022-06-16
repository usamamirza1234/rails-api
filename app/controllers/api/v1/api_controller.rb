module Api
  module V1
    class ApiController < ApplicationController
      include ActionController::HttpAuthentication::Token
      before_action :set_user

      private

      def set_user
        # authenticate_user!
        # current_user.blank?
        token, _option = token_and_options(request)
        user_id = AuthenticationTokenService.decode(token)
        User.find(user_id)
      rescue JWT::DecodeError
        render json: failure_messages(:bad_request, "Token not found", [],"Token is null"), status: :bad_request
      rescue JWT::VerificationError
        render json: failure_messages(:unprocessable_entity, "Invalid or expired token", []), status: :unprocessable_entity
      rescue ActiveRecord::RecordNotFound
        render json: failure_messages(:not_found, "No User Found", []), status: :not_found
      end

      def failure_messages(status, message, data, *args)
        {
          status: status, messages: message, errors: args, data: data
        }
      end
      def success_messages(status,message,data, *args)
        {
          status: status,
          messages: message,
          data: data,
          errors: args
        }
      end

    end
  end
end

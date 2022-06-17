module Api
  module V1
    class ApiController < ApplicationController
      include ActionController::HttpAuthentication::Token
      before_action :set_user
      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from JWT::DecodeError, with: :nill_token
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from JWT::VerificationError, with: :verification_failed


      private

      def set_user
        # authenticate_user!
        # current_user.blank?
        token, _option = token_and_options(request)
        user_id = AuthenticationTokenService.decode(token)
        User.find(user_id)
           # rescue JWT::DecodeError
        # render json: failure_messages(:bad_request, "Token not found", [],"Token is null"), status: :bad_request
      # rescue JWT::VerificationError
      #   render json: failure_messages(:unprocessable_entity, "Invalid or expired token", []), status: :unprocessable_entity
      # # rescue ActiveRecord::RecordNotFound

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
      def parameter_missing(e)
        render json: failure_messages(:unprocessable_entity, "Params required", params,e.message), status: :unprocessable_entity
      end

      def record_not_found
        render json: failure_messages(:not_found, "No Record Found against your request", params), status: :not_found
      end

      def verification_failed
        render json: failure_messages(:unprocessable_entity, "Invalid or expired token", params), status: :unprocessable_entity
      end

      def nill_token
        render json: failure_messages(:bad_request, "Token not found", [],"Token is null"), status: :bad_request
      end

    end
  end
end

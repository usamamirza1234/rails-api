module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      before_action :ensure_params_exist, only: :create
      # skip_before_action :verify_authenticity_token, :only => :create
      # sign up
      def create
        user = User.new user_params
        if user.save
          render json: success_messages(:created,"Signed Up Successfully",user), status: :created
        else
          render json: failure_messages(:unprocessable_entity,"Signed Up Failed",[],user.errors.full_messages), status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation,:user_type, :name)
      end

      def ensure_params_exist
        return if params[:user].present?
        render json: failure_messages(:bad_request,"Missing Params",[],"Something went wrong"), status: :bad_request
      end

      def success_messages(status,message,data, *args)
        {
          status: status,
          messages: message,
          data:
            {
              user: {
                user_name: data.name,
                user_email: data.email,
                user_type: data.user_type,
              }
            },
          errors: args
        }
      end

      def failure_messages(status,message,data, *args)
        {
          status: status,
          messages: message,
          errors: args,
          data: data
        }
      end

    end
  end
end

# class Api::V1::RegistrationsController < Devise::RegistrationsController
#   before_action :ensure_params_exist, only: :create
#   # skip_before_action :verify_authenticity_token, :only => :create
#   # sign up
#   def create
#     user = User.new user_params
#     if user.save
#       render json: { messages: "Sign Up Successfully", is_success: true, data: { user: user }
#       }, status: :ok
#     else render json: { messages: "Sign Up Failed", is_success: false, data: {}
#     }, status: :unprocessable_entity
#     end
#   end
#
#   private
#
#   def user_params
#     params.require(:user).permit(:email, :password, :password_confirmation,:user_type, :name)
#   end
#
#   def ensure_params_exist
#     return if params[:user].present?
#     render json: { messages: "Missing Params", is_success: false, data: {}
#     }, status: :bad_request
#   end
# end
module Api
  module V1
    class SessionsController < Devise::SessionsController
      before_action :sign_in_params, only: :create
      before_action :load_user, only: :create


      # sign in
      def create
        if @user.valid_password?(sign_in_params[:password])
          sign_in "user", @user
          render json: success_messages(:ok,"Signed In Successfully",@user), status: :ok
        else
          render json: failure_messages(:unauthorized,"Signed In Failed - Unauthorized",[],"user email or password is wrong"), status: :unauthorized
        end
      end

      private
      def sign_in_params
        params.require(:user).permit :email, :password
      end

      def load_user
        @user = User.find_for_database_authentication(email: sign_in_params[:email])
        if @user
          @user
        else
          render json: failure_messages(:not_found,"Cannot get User",[],"user is invalid"), status: :not_found
        end
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
              token: AuthenticationTokenService.encode(data.id)
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
#
# class Api::V1::SessionsController < Devise::SessionsController
#   before_action :sign_in_params, only: :create
#   before_action :load_user, only: :create
#   # sign in
#   def create
#     if @user.valid_password?(sign_in_params[:password])
#       sign_in "user", @user
#       render
#       render json: {
#         messages: "Signed In Successfully",
#         is_success: true,
#         data: {user: @user}
#       }, status: :ok
#     else
#       render json: {
#         messages: "Signed In Failed - Unauthorized",
#         is_success: false,
#         data: {}
#       }, status: :unauthorized
#     end
#   end
#
#   private
#   def sign_in_params
#     params.require(:user).permit :email, :password
#   end
#
#   def load_user
#     @user = User.find_for_database_authentication(email: sign_in_params[:email])
#     if @user
#       @user
#     else
#       render json: {
#         messages: "Cannot get User",
#         is_success: false,
#         data: {}
#       }, status: 401
#     end
#   end
# end
module Api
  module V1
    class BlogsController < ApiController

      skip_before_action :set_user, :only => :index
      before_action :set_user, only: [:create]

      def index
        data = BlogPresenter.new(Blog.all).as_json
        render json: success_messages(:ok,"Blogs Successfully Fetched",data), status: :ok
      end

      def create

      end


    end
  end
end
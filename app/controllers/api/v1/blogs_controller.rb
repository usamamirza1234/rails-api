module Api
  module V1
    class BlogsController < ApiController

      skip_before_action :set_user, :only => :index
      before_action :set_user, only: [:create,:destroy]


      def index
        data = BlogPresenter.new(Blog.all).as_json
        render json: success_messages(:ok,"Blogs Successfully Fetched",data), status: :ok
      end

      def create
        blog = Blog.new blog_params
        if blog.save
          render json: success_messages(:created,"Blogs Successfully Created", BlogPresenter.new(blog).get_blog), status: :created
        else
          render json: failure_messages(:unprocessable_entity,"Blogs is not created",[],blog.error.full_messages), status: :unprocessable_entity
        end
      end


      def destroy
        set_blog.destroy!
        render json: success_messages(:ok,"Blogs Successfully deleted", []), status: :ok
      end


      private

      def set_blog
        Blog.find(params[:id])
      end

      def blog_params
        params.require(:blog).permit(:heading, :sub_heading)
      end

    end
  end
end
module Api
  module V1
    class PostsController < ApiController

      skip_before_action :set_user, :only => :index
      before_action :set_user, only: [:create,:destroy]
      before_action :set_post, only: [:show,:destroy]


      def index
        posts = Post.all.order("created_at desc").joins(:thumbnail_attachment, :banner_attachment).paginate(page: params[:page])
        data = posts.map { |post| attachments(post) }
        render json: success_messages(:ok,"Post Successfully Fetched", data), status: :ok
      end

      def show
        @post =  set_post
        views =  @post.views + 1
        @post.update(views: views)
        data =  attachments(@post)
        render json: success_messages(200,"Post Successfully Created",data), status: :ok
      end

      def create
        post = Post.new post_params
        post.user = set_user
        if post.save
          data =  attachments(post)
          render json: success_messages(201,"Post Successfully Created", data), status: :created
        else
          render json: failure_messages(422,"Post is not created",[],post.errors.full_messages), status: :unprocessable_entity
        end
      end


      def destroy
        set_post.destroy!
        render json: success_messages(204,"Post Successfully deleted", []), status: :ok
      end


      private

      def set_post
        Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :views, :body, :thumbnail, :banner)
      end

      def attachments(post)
        PostPresenter.new(post).get_post
          #            .merge(
          # {
          #   banner_path: url_for(post.banner),
          #   thumbnail_path: url_for(post.thumbnail)
          # }
        # )
      end
    end
  end
end
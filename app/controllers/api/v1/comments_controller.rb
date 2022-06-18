module Api
  module V1
    class CommentsController < ApiController

      before_action :find_commentable, :only => :create
      before_action :set_comment, :except => :create

      def create
        @comment = @commentable.comments.build(comment_params)
        @comment.user = current_user
        @comment.reply = true if params[:comment_id]
        @comment.save
        render json: success_messages(:ok,"Commets Successfully Fetched", @comment), status: :ok
      end

      def edit; end

      def update
        if @comment.edit_history == ''
          # if \n => replace \n with <br/><hr/>
          @comment.edit_history = 'Original: ' + @comment.body.body.to_plain_text + "\n"
        else
          @comment.edit_history = @comment.edit_history + 'Edit: ' + params[:comment][:body] + "\n"
        end
        @comment.update(comment_params)
      end

      def destroy
        @comment.destroy
      end

      def history; end
      private

      def set_comment
        @comment = Comment.find(params[:id])
      end

      def find_commentable
        # Comment
        if params[:comment_id]
          @commentable = Comment.find_by_id(params[:comment_id])
        elsif params[:post_id]
          @commentable = Post.find_by_id(params[:post_id])
        end
      end

      def comment_params
          params.require(:comment).permit(:body)
      end
    end
  end

end

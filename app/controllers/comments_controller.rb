class CommentsController < ApplicationController
  def create
    @comment = current_user.authored_comments.new(comment_params)

    flash[:errors] = @comment.errors.full_messages unless @comment.save
    redirect_to @comment.commentable_type.constantize.find(@comment.commentable_id)
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end

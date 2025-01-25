class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      # redirect_to @post, notice: 'Comment added successfully!'
    else
      redirect_to @post, alert: 'Failed to add comment.'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.post, notice: 'Comment deleted successfully!'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end

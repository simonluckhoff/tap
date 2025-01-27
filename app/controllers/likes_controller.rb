class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.create(post: @post)

    respond_to do |format|
      format.json { render json: { liked: true } } # Respond with JSON indicating the post is liked
      format.html { redirect_to posts_path }
      format.turbo_stream
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = current_user.likes.find_by(post: @post)
    @like&.destroy

    respond_to do |format|
      format.json { render json: { liked: false } } # Respond with JSON indicating the post is unliked
      format.html { redirect_to posts_path }
      format.turbo_stream
    end
  end
#     before_action :set_post

#   def like
#     current_user.likes.create(post: @post)
#     # Handle success, e.g., redirect or render response
#   end

#   def unlike
#     like = current_user.likes.find_by(post: @post)
#     if like
#       like.destroy
#       # Handle success, e.g., redirect or render response
#     else
#       # Handle case where the like does not exist
#     end
#   end


#   def create
#     @post = Post.find(params[:post_id])
#     @like = @post.likes.new(user: current_user)

#     if @like.save
#         respond_to do |format|
#             format.html { redirect_to @post, notice: 'You liked this post.' }
#             format.json { render json: { liked: true }, status: :created }
#         end
#     else
#         respond_to do |format|
#             format.html { redirect_to @post, alert: 'Unable to like this post.' }
#             format.json { render json: { error: @like.errors.full_messages }, status: :unprocessable_entity }
#         end
#     end
# end

# def destroy
#     @post = Post.find(params[:post_id])
#     @like = @post.likes.find_by(user: current_user)

#     if @like&.destroy
#         respond_to do |format|
#             format.html { redirect_to @post, notice: 'You unliked this post.' }
#             format.json { render json: { liked: false }, status: :ok }
#         end
#       else
#         respond_to do |format|
#             format.html { redirect_to @post, alert: 'Unable to unlike this post.' }
#             format.json { render json: { error: 'Like not found.' }, status: :not_found }
#         end
#     end
# end

# private

# def set_post
#   @post = Post.find(params[:post_id])
# end
end

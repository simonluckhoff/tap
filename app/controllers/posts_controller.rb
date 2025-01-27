class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def show
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user # Associate the post with the current user
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully deleted.'
  end

  def like
    @post = Post.find(params[:id])
    # Check if the user has already liked the post
    if current_user.likes.exists?(post: @post)
      render json: { error: "You have already liked this post." }, status: :unprocessable_entity
    else
      current_user.likes.create(post: @post)
      render json: { message: "You liked the post." }, status: :ok
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Post not found." }, status: :not_found
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :media_url, interest_ids: [])
  end
end

class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:user).order(created_at: :desc) # Load user's posts
  end

  def follow
    @user_to_follow = User.find(params[:id])

    if current_user.following.include?(@user_to_follow)
      render json: { message: "You are already following #{@user_to_follow.username}." }, status: :unprocessable_entity
    else
      current_user.follow(@user_to_follow)
      render json: { message: "You are now following #{@user_to_follow.username}." }, status: :ok
    end
  end

  def unfollow
    @user_to_unfollow = User.find(params[:id])

    if current_user.following.include?(@user_to_unfollow)
      current_user.unfollow(@user_to_unfollow)
      render json: { message: "You have unfollowed #{@user_to_unfollow.username}." }, status: :ok
    else
      render json: { message: "You are not following #{@user_to_unfollow.username}." }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :photo)
  end
end

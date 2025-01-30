class FollowsController < ApplicationController
  before_action :authenticate_user!

  # def index
  #   @following = current_user.following
  # end

  # Display users you're following
  def following
    @following = current_user.following
  end

  # Display users who follow you
  def followers
    @followers = current_user.followers
  end

  def create
    @user_to_follow = User.find(params[:id])
    if current_user.follow(@user_to_follow)
      render json: { following: true }, status: :ok
    else
      render json: { error: "Unable to follow user" }, status: :unprocessable_entity
    end
  end

  def destroy
    @user_to_unfollow = User.find(params[:id])
    if current_user.unfollow(@user_to_unfollow)
      render json: { following: false }, status: :ok
    else
      render json: { error: "Unable to unfollow user" }, status: :unprocessable_entity
    end
  end
end

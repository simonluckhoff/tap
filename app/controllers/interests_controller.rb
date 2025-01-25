class InterestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_interest, only: [:show, :follow, :unfollow]

  def index
    @interests = Interest.all
    @user_interests = current_user.interests
  end

  def show
    @posts = @interest.posts.includes(:user).order(created_at: :desc)
  end

  def follow
    current_user.interests << @interest unless current_user.interests.include?(@interest)
    redirect_to @interest, notice: "You are now following #{@interest.name}"
  end

  def unfollow
    current_user.interests.delete(@interest)
    redirect_to @interest, notice: "You have unfollowed #{@interest.name}"
  end

  private

  def set_interest
    @interest = Interest.find(params[:id])
  end
end

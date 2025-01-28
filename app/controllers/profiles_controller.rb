class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    # @users = User.all
    if params[:query].present?
      @users = User.search_by_username(params[:query])
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:user).order(created_at: :desc) # Load user's posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :bio) # Add :avatar if you have an avatar field
  end
end

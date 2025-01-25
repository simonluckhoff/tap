class UserInterestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @interest = Interest.find(params[:interest_id])
    current_user.interests << @interest unless current_user.interests.include?(@interest)
    redirect_back(fallback_location: interests_path, notice: "Added to your interests")
  end

  def destroy
    @interest = Interest.find(params[:interest_id])
    current_user.interests.delete(@interest)
    redirect_back(fallback_location: interests_path, notice: "Removed from your interests")
  end
end

class RelationshipsController < ApplicationController

  before_action :forbid_follow, only: [:create]

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end


  private

  def forbid_follow
    user = User.find(params[:user_id])
    unless current_user != user
      redirect_to request.referer
    end
  end
end

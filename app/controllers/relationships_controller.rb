class RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:user_id])
    redirect_back fallback_location: {action: "index"}
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_back fallback_location: {action: "index"}
  end

  #followしているユーザーの一覧取得
  def followeds
    user = User.find(params[:user_id])
    @users = user.followeds
  end

  #followされているユーザーの一覧取得
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end

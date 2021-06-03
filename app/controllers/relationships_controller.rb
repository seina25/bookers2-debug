class RelationshipsController < ApplicationController

  # フォロー機能の作成・保存・削除
  def create
    current_user.follow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  # フォローとフォロワーの一覧ページ用
  def followings
    @user = User.find(params[:user_id])
    @following_users = @user.followings
  end

  def followers
    @user = User.find(params[:user_id])
    @follower_users = @user.followers
  end
end

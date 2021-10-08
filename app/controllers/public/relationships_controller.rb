class Public::RelationshipsController < ApplicationController
  # ログインしてなければフォローできなくする
  before_action :authenticate_user!

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
    # request.referer 遷移前のページにリダイレクト
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings
    user = User.find(params[:user_id])
    @usres = user.follwings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end

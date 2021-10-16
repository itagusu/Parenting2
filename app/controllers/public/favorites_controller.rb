class Public::FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
    # redirect_to post_path(post)
    # 非同期通信のため app/view/public/favorites/create.js.
    @post.create_notification_favorite?(current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
    # redirect_to post_path(post)
    # 非同期通信のため app/view/public/favorites/destroy.js.erb
  end
end

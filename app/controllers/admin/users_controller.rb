class Admin::UsersController < ApplicationController
  before_action :authenticate_user!,except: [:index, :show, :edit, :update, :destroy]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_user_path(post.user)
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :introduction, :is_deleted)
  end
end

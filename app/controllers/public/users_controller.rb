class Public::UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless current_user.id == @user.id
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "更新しました！"
      redirect_to my_page_path(current_user)
    else
      render :edit
    end
  end

  def confirm; end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = 'ありがとうございました。またのご利用を心よりお待ちしております。'
    redirect_to new_user_session_path
  end

  def my_page
    @user = current_user
    @posts = @user.posts.page(params[:page]).per(10).order(created_at: :desc)
  end

  def favorite
    user = User.find(params[:id])
    @users = user.favorite
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :introduction, :profile_image)
  end
end

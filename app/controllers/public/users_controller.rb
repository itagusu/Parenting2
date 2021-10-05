class Public::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
    user = current_user
    user.update(user_params)
    #flash[:notice] = "You have updated user successfully."
    redirect_to my_page_path(current_user)
  end

  def confirm
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to new_user_session_path
  end

  def my_page
    @user = current_user
  end

private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :introduction, :profile_image)
  end


end
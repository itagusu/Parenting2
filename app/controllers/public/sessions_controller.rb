# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: %i[create is_deleted]

  def reject_inactive_user
    @user = User.find_by(email: params[:user][:email])
    if @user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false)
      redirect_to new_user_session_pathend
    end
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def after_sign_in_path_for(_resource)
    my_page_path(current_user)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
end

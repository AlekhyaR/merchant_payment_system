# frozen_string_literal: true

class Users::SessionsController < ApplicationController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    @user = User.new
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  def create
    user = User.find_by_email(params[:user][:email])
    @current_user_id = user.id
    token = AuthenticationTokenService.generate_token(merchant_user_id: user.id)
    render json: {token: token}, status: :created
    # else
    #   render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    # end
  end
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :encrypted_password])
  # end
end
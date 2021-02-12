class Merchants::SessionsController < ApplicationController
  skip_before_action :authenticate_user
  respond_to :html

  def new
    @merchant_user = User.new(role: 0)
  end

  def create 
    @user = User.find_by_email(params["user"]["email"])
    if @user.present? && @user.merchant?
      session[:user_id] = @user.id
      redirect_to merchants_transactions_path, flash: { success: t('merchants.sessions.create.success') }
    else
      flash.now[:error] = t('controllers.create.flash.error')
      render :new
    end
  end

  def destroy
    log_out 
    redirect_to root_url
  end
end
class Admins::SessionsController < ApplicationController
  skip_before_action :authenticate_user
  respond_to :html

  def new
    @admin_user = User.new(role: 1)
  end

  def create 
    @admin_user = User.find_by_email(params["user"]["email"])
    if @admin_user.present? && @admin_user.admin?
      session[:user_id] = @admin_user.id
      redirect_to admins_merchants_path, flash: { success: t('merchants.sessions.create.success') }
    else
      render 'new'
    end
  end

  def destroy
    log_out 
    redirect_to root_url
  end
end
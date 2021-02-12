module ApplicationHelper
  def authenticate_user(options = {})
    head :unauthorized unless signed_in?
  end

  def signed_in?
    @current_user.present?
  end

  def current_user
    @current_user ||= super || User.find(@current_user.id)
  end

  def admin_user?
    @current_user.admin?
  end

  def admin_signed_in?
    signed_in? && admin_user? 
  end

  def merchant_user?
    @current_user.merchant?
  end

  def merchant_signed_in?
    signed_in? && merchant_user? 
  end

  def current_admin
    @current_user if admin_user?
  end

  def current_merchant
    @current_user if merchant_user?
  end
end

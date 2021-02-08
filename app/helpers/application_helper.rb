module ApplicationHelper
  def authenticate_user!(options = {})
    head :unauthorized unless signed_in?
  end

  def signed_in?
    @current_user_id.present?
  end

  def current_user
    @current_user ||= super || User.find(@current_user_id)
  end

  def current_admin_user?
    current_user.admin?
  end

  def admin_signed_in?
    current_admin_user? && @current_user_id.present? 
  end

  def current_merchant_user?
    current_user.merchant?
  end

  def merchant_signed_in?
    current_merchant_user? && @current_user_id.present? 
  end
end

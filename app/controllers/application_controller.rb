class ApplicationController < ActionController::Base
  respond_to :html, :json

  include Operation::ControllerHelpers
  include ApplicationHelper
  include SessionHelper

  MERCHANT = "merchant"

  before_action :set_current_user, :authenticate_user, :set_locale

  rescue_from Operation::NotAuthorizedError do
    render plain: I18n.t('controllers.unauthorized'), status: :unauthorized
  end

  def authenticate_user
    if @current_user.nil?
      flash[:error] = 'You must be signed in to view that page.'
      if request.original_url.include? MERCHANT
        redirect_to merchants_sign_in_path
      else
        redirect_to admins_sign_in_path
      end
    end
  end

  private

  def set_current_user
    @current_user = session[:user_id] ? User.find(session[:user_id]) : nil
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end

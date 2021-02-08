class HomeController < ApplicationController
  def index
    if signed_in?
      if current_merchant_user?
        redirect_to merchants_transactions_path
      elsif current_admin_user?
        redirect_to admins_merchants_path
      end
    end
  end
end

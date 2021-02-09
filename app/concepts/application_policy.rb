# frozen_string_literal: true
class ApplicationPolicy
  def initialize(user, _object)
    @user = user
    @user_object = _object
  end

  def admin?
    @user_object.admin!
    @user_object.admin?
  end

  def merchant?
    @user_object.merchant!
    @user_object.merchant?
  end
end

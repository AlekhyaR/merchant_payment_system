# frozen_string_literal: true
class ApplicationPolicy
  def initialize(user, _object)
    @user = user
    @user_object = _object
  end

  def admin?
    @user.admin?
  end

  def merchant?
    @user.merchant?
  end
end

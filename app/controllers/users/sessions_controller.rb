class Users::SessionsController
  def new
    @user = User.find_by(id: 1)
  end
end
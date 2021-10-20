module RequestHelper
  def logged_in_admin
    admin.activate!
    login_user(admin, 'password')
  end

  def logged_in_user
    user.activate!
    login_user(user, 'password')
  end
end

module RequestHelper
  def login_user
    user.confirm
    sign_in user
  end
end

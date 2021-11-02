module RequestHelper
  def login_user
    user.confirm
    sign_in user
  end

  def login_other
    other.confirm
    login_as other
  end
end

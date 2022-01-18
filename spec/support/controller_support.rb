module ControllerSupport
  # return true if test user logged in
  def is_logged_in?
    !session[:user_id].nil?
  end

  # log in as test user
  def log_in_as(user, password: 'password')
    post sessions_path, params: { session: {
      name_or_email: user.email,
      password: password
    } }
  end
end
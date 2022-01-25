module ControllerSupport
  # return true if test user logged in
  def is_logged_in?
    !session[:user_id].nil?
  end

  # log in as test user
  def log_in_as(user, password: 'password')
    activate_as(user)
    post sessions_path, params: { session: {
      name_or_email: user.email,
      password: password
    } }
  end

  # log out as test user
  def log_out_as(user)
    delete session_path(user)
  end

  # activation as test user
  def activate_as(user)
    get edit_account_activation_path(user.activation_token, email: user.email)
    log_out_as(user) # to log in when user account activation
  end
end
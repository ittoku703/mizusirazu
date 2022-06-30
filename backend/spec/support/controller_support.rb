module ControllerSupport
  # # # # # # # # # # # # # # # # # #
  # rspec user authentication methods
  # # # # # # # # # # # # # # # # # #

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

  def allow_recaptcha
    allow_any_instance_of(Recaptcha::Adapters::ControllerMethods).to receive(:verify_recaptcha).and_return(false)
  end

  # # # # # # # # # # # # # # # # # #
  # rspec test methods
  # # # # # # # # # # # # # # # # # #

  def it_should_be_success()
    expect(response).to(have_http_status(200))
  end

  def it_redirect_to(path)
    expect(response).to(redirect_to(path))
  end

  def it_render(action)
    expect(response).to(render_template(action))
  end

  def it_status_code_is(code)
    expect(response).to(have_http_status(code))
  end

  def it_send_email()
    expect(ActionMailer::Base.deliveries.count).to(eq(1))
  end

  def it_no_send_email()
    expect(ActionMailer::Base.deliveries.count).to(eq(0))
  end

  def it_create_object(object)
    expect(object.count).to(eq(1))
  end

  def it_delete_object(object)
    expect(object.count).to(eq(0))
  end

  def it_send_deliver_later_email()
    assert_enqueued_emails(1)
  end
end

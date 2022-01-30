module FeatureSupport
  def log_in_as(user)
    user.activate
    visit new_session_path()
    fill_in 'Name or email', with: user.name
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  def activate_as(user)
    visit new_account_activation_path
    fill_in 'Email', with: user.email
    click_button 'Activate'
    expect(page).to have_selector 'div#notice'
    visit activation_email_link
    log_in_as(user)
  end

  def activation_email_link
    activation_email = ActionMailer::Base.deliveries.last
    email_body = activation_email.body.encoded
    reg_url = %r{http://localhost:3000/confirms/[\w=%.?/-]*}
    email_body.match(reg_url).to_s
  end

  def password_reset_email_link
    activation_email = ActionMailer::Base.deliveries.last
    email_body = activation_email.body.encoded
    reg_url = %r{http://localhost:3000/passwords/[\w=%.?/-]*}
    email_body.match(reg_url).to_s
  end
end
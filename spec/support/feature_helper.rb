module FeatureHelper
  def logged_in_user
    user.activate!
    visit new_user_session_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 'password'
    click_button t('login')
  end

  def email_link
    mail = ActionMailer::Base.deliveries.last
    mail.body.parts[0].body.match(%r{(http|https)://localhost:\d+/[\w!?+-_~=;.,*&@#$%/]+})
  end

  def t(value)
    I18n.t(value)
  end
end

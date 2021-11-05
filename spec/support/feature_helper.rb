module FeatureHelper
  def login_user
    user.confirm
    login_as user
  end

  def email_link
    mail = ActionMailer::Base.deliveries.last
    mail.body.match(%r{(http|https)://localhost:\d+/[\w!?+-_~=;.,*&@#$%/]+})
  end

  def t(value)
    I18n.t(value)
  end

  def l(value)
    I18n.localize(value)
  end

  def edit_user_password_link
    visit new_user_password_path
    fill_in 'user[email]', with: user.email
    click_button t('reset_password')
    email_link
  end
end

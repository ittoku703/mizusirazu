module FeatureHelper
  def email_link
    mail = ActionMailer::Base.deliveries.last
    mail.body.parts[0].body.match(%r{(http|https)://localhost:\d+/[\w!?+-_~=;.,*&@#$%/]+})
  end

  def t(value)
    I18n.t(value)
  end
end

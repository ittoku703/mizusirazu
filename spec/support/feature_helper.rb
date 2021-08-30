module FeatureHelper

  def visit_email_link_url
    mail = ActionMailer::Base.deliveries.last
    body = mail.body.encoded
    visit body[%r(http(s)?://localhost:[\d]+/[\w\-]+([\w\-/?\=]*))]
  end

  def login_user
    login_as build(:user)
  end

end

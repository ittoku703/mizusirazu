module FeatureHelper

  def extract_url(mail)
    body = mail.body.encoded
    body[%r(http(s)?://localhost:[\d]+/[\w\-]+([\w\-/?\=]*))]
  end

  def login_user
    login_as build(:user)
  end

end

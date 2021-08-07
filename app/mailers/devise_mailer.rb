class DeviseMailer < Devise::Mailer
  helper :application # gives access to all healpers defined with in `application_helper`
  layout 'mailer'
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer'

  def confirmation_instructions(record, token, opts={})
    super
  end

  def reset_password_instructions(record, token, opts={})
    super
  end

  def unlock_instructions(record, token, opts={})
    super
  end

  def email_changed(record, opts={})
    super
  end

  def password_change(record, opts={})
    super
  end
end

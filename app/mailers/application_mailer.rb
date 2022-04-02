class ApplicationMailer < ActionMailer::Base
  default from: I18n.t('notifications_email')
  layout 'mailer'
end

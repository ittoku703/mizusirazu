class StaticMailer < ApplicationMailer

  def contact(params_contact)
    @params_contact = params_contact
    contact_mail = {
      :from    => 'contact@mizusirazu.net',
      :to      => ENV['WEBSITE_EMAIL'],
      :subject => t('.subject')
    }

    mail(contact_mail)
  end
end

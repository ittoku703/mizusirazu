require 'rails_helper'

RSpec.describe StaticMailer, type: :mailer do
  describe 'contact' do
    let!(:params_contact) { { reply_email: 'reply@email.com', content: 'hello' } }
    let!(:mail) { StaticMailer.contact(params_contact) }

    it 'renders the headers' do
      expect(mail.subject).to eq(I18n.t('static_mailer.contact.subject'))
      # expect(mail.to).to eq([ENV['WEBSITE_EMAIL']])
      expect(mail.from).to eq(['contact@mizusirazu.net'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(params_contact[:reply_email])
      expect(mail.body.encoded).to match(params_contact[:content])
    end
  end
end

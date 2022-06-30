require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do

  describe 'account_activation' do
    let!(:user) { create(:user) }
    let!(:mail) { UserMailer.account_activation(user) }
    let!(:mail_body) { mail.body.parts.first.body }

    it 'renders the headers' do
      expect(mail.subject).to eq I18n.t('user_mailer.account_activation.subject')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['account-activation@mizusirazu.net'])
    end

    it 'renders the body' do
      expect(mail_body).to match(user.name)
      expect(mail_body).to match(edit_account_activation_url(user.activation_token))
    end
  end

  describe 'password_reset' do
    let!(:user) { create(:user, reset_token: User.new_token) }
    let!(:mail) { UserMailer.password_reset(user) }
    let!(:mail_body) { mail.body.parts.first.body }

    it 'renders the headers' do
      expect(mail.subject).to eq(I18n.t('user_mailer.password_reset.subject'))
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['password-reset@mizusirazu.net'])
    end

    it 'renders the body' do
      expect(mail_body).to match(user.name)
      expect(mail_body).to match(CGI.escape(user.email))
    end
  end
end

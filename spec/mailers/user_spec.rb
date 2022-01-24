require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }

  describe 'account_activation' do
    let(:mail) { UserMailer.account_activation(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Account activation')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['notifications@mizusirazu.net'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(user.name)
      expect(mail.body.encoded).to match(edit_account_activation_url(user.activation_token))
    end
  end

end

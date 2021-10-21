require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }

  describe '#activation_needed_email' do
    subject(:mail) do
      user.activation_token = 'activation_token'
      described_class.activation_needed_email(user).deliver_now
    end

    it { expect(mail.from.first).to eq 'notifications@mizusirazu.net' }
    it { expect(mail.to.first).to eq user.email }
    it { expect(mail.subject).to eq 'Welcome to Mizusirazu.net' }

    it 'url found' do
      url = %r{http://localhost:3000/users/activation_token/activate}
      expect(mail.body.parts[0].body).to match(url)
    end
  end

  describe '#activation_success_email' do
    subject(:mail) { described_class.activation_success_email(user).deliver_now }

    it { expect(mail.from.first).to eq 'notifications@mizusirazu.net' }
    it { expect(mail.to.first).to eq user.email }
    it { expect(mail.subject).to eq "#{user.email} is now activated" }
    it { expect(mail.body.parts[0].body).to match(/Welcome to Mizusirazu.net/) }
  end

  describe '#reset_password_email' do
    subject(:mail) do
      user.reset_password_token = 'reset_password_token'
      described_class.reset_password_email(user).deliver_now
    end

    it { expect(mail.from.first).to eq 'notifications@mizusirazu.net' }
    it { expect(mail.to.first).to eq user.email }
    it { expect(mail.subject).to eq 'Reset password' }

    it 'url found' do
      url = %r{http://localhost:3000/password/reset_password_token/edit}
      expect(mail.body.parts[0].body.raw_source).to match(url)
    end
  end
end

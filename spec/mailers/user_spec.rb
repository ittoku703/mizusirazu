require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }

  describe '.confirmation_instructions' do
    subject(:mail) { UserMailer.confirmation_instructions(user, 'fake token') }
    it { expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.size }.by(1) }
    it { expect(mail.subject).to eq 'アカウントの有効化について' }
    it { expect(mail.to).to eq [user.email] }
    it { expect(mail.from).to eq ['noreply@mizusirazu.net'] }
    it { expect(mail.body.encoded).to match "Welcome #{user.email}" }
    it { expect(mail.body.encoded).to match user_confirmation_path }
  end

  describe '.reset_password_instructions' do
    subject(:mail) { UserMailer.reset_password_instructions(user, 'fake token') }
    it { expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.size }.by(1) }
    it { expect(mail.subject).to eq 'パスワードの再設定について' }
    it { expect(mail.to).to eq [user.email] }
    it { expect(mail.from).to eq ['noreply@mizusirazu.net'] }
    it { expect(mail.body.encoded).to match "Hello #{user.email}" }
    it { expect(mail.body.encoded).to match edit_user_password_path }
  end

  describe '.unlock_instructions' do
    subject(:mail) { UserMailer.unlock_instructions(user, 'fake token') }
    it { expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.size }.by(1) }
    it { expect(mail.subject).to eq 'アカウントの凍結解除について' }
    it { expect(mail.to).to eq [user.email] }
    it { expect(mail.from).to eq ['noreply@mizusirazu.net'] }
    it { expect(mail.body.encoded).to match "Hello #{user.email}" }
    it { expect(mail.body.encoded).to match user_unlock_path }
  end
end

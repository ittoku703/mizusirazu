require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }
  describe ".reset_password_instructions" do
    subject(:mail) { UserMailer.reset_password_instructions(user, 'fake token') }
    it { expect{mail.deliver_now}.to change{ActionMailer::Base.deliveries.size}.by(1) }
    it { expect(mail.subject).to eq "パスワードの再設定について" }
    it { expect(mail.to).to eq [user.email] }
    it { expect(mail.from).to eq ['noreply@mizusirazu.net'] }
    it { expect(mail.body.encoded).to match "Hello #{user.email}" }
    it { expect(mail.body.encoded).to match edit_user_password_path }
  end
end

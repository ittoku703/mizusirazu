require "rails_helper"

RSpec.describe Devise::Mailer, type: :mailer do
  let!(:user) { create(:user) }

  before { ActionMailer::Base.deliveries.clear }

  describe '#confirmation_instructions' do
    subject(:mail) { described_class.confirmation_instructions(user, 'fake token').deliver_now }

    it { is_expected.to have_sent_email }
    it { is_expected.to have_sent_email.from('info@mizushirazu.net') }
    it { is_expected.to have_sent_email.to(user.email) }
    it { is_expected.to have_sent_email.with_subject('Confirmation instructions') }
  end

  describe '#reset_password_instructions' do
    subject(:mail) { described_class.reset_password_instructions(user, 'fake token').deliver_now }

    it { is_expected.to have_sent_email }
    it { is_expected.to have_sent_email.from('info@mizushirazu.net') }
    it { is_expected.to have_sent_email.to(user.email) }
    it { is_expected.to have_sent_email.with_subject('Reset password instructions') }
  end

  describe '#unlock_instructions' do
    subject(:mail) { described_class.unlock_instructions(user, 'fake token').deliver_now }

    it { is_expected.to have_sent_email }
    it { is_expected.to have_sent_email.from('info@mizushirazu.net') }
    it { is_expected.to have_sent_email.to(user.email) }
    it { is_expected.to have_sent_email.with_subject('Unlock instructions') }
  end

  describe '#email_changed' do
    subject(:mail) { described_class.email_changed(user).deliver_now }

    it { is_expected.to have_sent_email }
    it { is_expected.to have_sent_email.from('info@mizushirazu.net') }
    it { is_expected.to have_sent_email.to(user.email) }
    it { is_expected.to have_sent_email.with_subject('Email Changed') }
  end

  describe '#password_change' do
    subject(:mail) { described_class.password_change(user).deliver_now }

    it { is_expected.to have_sent_email }
    it { is_expected.to have_sent_email.from('info@mizushirazu.net') }
    it { is_expected.to have_sent_email.to(user.email) }
    it { is_expected.to have_sent_email.with_subject('Password Changed') }
  end

end

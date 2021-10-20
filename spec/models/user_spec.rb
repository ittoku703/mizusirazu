require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user, activation_state: nil) }

  valid_email_regexp = %w[
    user@example.com
    user@example.co.jp
    USER@EXAMPLE.COM
    abc123-_-.@example.com
  ]
  invalid_email_regexp = %w[
    あいうえお@example.com
    user@example
    @example..com
    ~`!@#$%^&*()=+[{]}\|;:'",<>/?@example.com
  ]

  it 'is valid' do
    expect(user.valid?).to eq true
  end

  describe 'before_validation :downcase_email' do
    it 'is downcase before validation' do
      user.email = valid_email_regexp[2]
      expect { user.valid? }.to change(user, :email)
        .from(valid_email_regexp[2]).to(valid_email_regexp[2].downcase)
    end
  end

  describe 'before_update :setup_activation' do
    it 'is initialized activation value if email changed' do
      expect { user.save }.to change(user, :activation_state)
        .from(nil).to('pending')
    end
  end

  describe 'after_update :send_activation_needed_email!' do
    it 'is send activation email if email changed' do
      expect { user.save }.to change(ActionMailer::Base.deliveries, :count)
        .by(1)
    end
  end

  describe 'email' do
    context 'is valid because it' do
      it 'is valid email regexp' do
        valid_email_regexp.each do |email|
          user.email = email
          expect(user.valid?).to eq true
        end
      end
    end

    context 'is invalid because it' do
      it 'is empty' do
        user.email = ''
        expect(user.valid?).to eq false
      end

      it 'is invalid regexp' do
        invalid_email_regexp.each do |email|
          user.email = email
          expect(user.valid?).to eq false
        end
      end

      it 'is too long (max: 255)' do
        user.email = "#{'x' * 255}@example.com"
        expect(user.valid?).to eq false
      end

      it 'is same' do
        user_dup = user.dup
        user.save
        expect(user_dup.valid?).to eq false
      end
    end
  end

  describe 'password' do
    context 'is invalid because it' do
      it 'is too short' do
        user.password = 'xx'
        expect(user.valid?).to eq false
      end

      it 'is too long' do
        user.password = 'x' * 1000
        expect(user.valid?).to eq false
      end

      it 'is confirmation empty' do
        user.password_confirmation = ''
        expect(user.valid?).to eq false
      end
    end
  end
end

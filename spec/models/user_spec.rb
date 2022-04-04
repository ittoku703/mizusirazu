require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it { user_valid?(user) }

  describe '.name' do
    it 'should be present' do
      user.name = ''
      user_invalid?(user)
    end

    it 'should accept valid value' do
      valid_names = %w[
        shinzanmono_14
        1234asdf
        ittoku___24
      ]
      valid_names.each do |valid_name|
        user.name = valid_name
        user_valid?(user)
      end
    end

    it 'should reject invalid value' do
      invalid_names = %w[
        HOGEHOGE_15
        aaaa:23
        bbbb-1234
        cccc1234.hoge
      ]
      invalid_names.each do |invalid_name|
        user.name = invalid_name
        user_invalid?(user)
      end
    end

    it 'length should be 128 less' do
      user.name = 'a' * 129
      user_invalid?(user)
    end

    it 'should be unique' do
      dup_user = user.dup
      user.save
      user_invalid?(dup_user)
    end
  end

  describe '.email' do
    it 'should be present' do
      user.email = ''
      user_invalid?(user)
    end

    it 'should accept valid addresses' do
      valid_addresses = %w[
        hoge@bar.com
        hoge@bar.co.jp
        h_o-g_e-1.2.3.4@bar.com
      ]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        user_valid?(user)
      end
    end

    it 'should reject invalid addresses' do
      invalid_addresses = %w[
        hoge::bar@baz.com
        hoge+*&@bar.com
        hoge@bar
      ]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        user_invalid?(user)
      end
    end

    it 'length should be 256 less' do
      user.email = 'x' * 245 + '@example.com' # <- length of 257
      user_invalid?(user)
    end

    it 'should be unique' do
      dup_user = user.dup
      user.save
      user_invalid?(dup_user)
    end
  end

  describe '.password' do
    it 'should be present' do
      user.password = ' '
      user_invalid?(user)
    end

    it 'length should be 4 more' do
      user.password = 'x' * 3
      user_invalid?(user)
    end

    it 'length should be 256 less' do
      user.password = 'x' * 257
      user_invalid?(user)
    end
  end

  describe '.activation_digest' do
    it 'should create activation_digest and token when user created' do
      expect { user.save }.to(
        change { user.activation_digest.is_a?(String) }.from(false).to(true) &&
        change { user.activation_token.is_a?(String) }.from(false).to(true)
      )
    end
  end

  describe '.profile' do
    before do
      user.save
    end

    it 'should be delete when user destroyed' do
      expect { user.destroy }.to change(Profile, :count).by(-1)
    end
  end

  describe '.provider' do
    before do
      user.save
      user.create_provider
    end

    it 'should be delete when user destroyed' do
      expect { user.destroy }.to change(Provider, :count).by(-1)
    end
  end

  describe 'microposts' do
    before do
      user.save
      user.microposts.create!(title: 'test', content: 'content')
    end

    it 'should be delete when user destroyed' do
      expect { user.destroy }.to change(Micropost, :count).by(-1)
    end
  end

  def user_valid?(user)
    expect(user).to be_valid
  end

  def user_invalid?(user)
    expect(user).not_to be_valid
  end

  ##### User methods test

  describe 'User.digest(string)' do
    it 'return Hash values of the passed string' do
      digest = User.digest('password')
      expect(digest.is_password?('password')).to eq true
    end
  end

  describe 'User.new_token()' do
    it 'return the random token' do
      expect(User.new_token.is_a?(String)).to eq true
    end
  end

  describe 'remember()' do
    before { user.save }

    it 'remember user in database for permanent sessions' do
      expect { user.remember }.to change { user.reload.remember_digest.is_a?(String) }.from(false).to(true)
    end
  end

  describe 'authenticated?(attribute, token)' do
    before { user.save; user.remember; }

    context 'token passed matched digest' do
      it 'return true' do
        expect(user.authenticated?(:remember, user.remember_token)).to eq true
      end
    end

    context 'token passed no matched digest' do
      it 'return false' do
        expect(user.authenticated?(:remember, 'hogehoge')).to eq false
      end
    end
  end

  describe 'forget()' do
    before { user.save; user.remember; }

    it 'user remember_digest is nil' do
      expect { user.forget }.to change { user.remember_digest.is_a?(NilClass) }.from(false).to(true)
    end
  end

  describe 'activate()' do
    before { user.save }

    it 'activation your account' do
      expect { user.activate }.to change { user.activated? }.from(false).to(true)
    end
  end

  describe 'send_account_activation_email()' do
    before do
      user.save
      user.activation_sent_at = nil
    end

    it 'should send email' do
      expect { user.send_account_activation_email() }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it 'should activation_sent_at is not empty' do
      expect { user.send_account_activation_email() }.to change { user.activation_sent_at.nil? }.from(true).to(false)
    end

    it 'should send email for 1 second after' do
      user.send_account_activation_email()
      expect { user.send_account_activation_email() }.to change(ActionMailer::Base.deliveries, :count).by(0)
    end
  end

  describe 'send_password_reset_email()' do
    before do
      user.save
      user.reset_sent_at = nil
    end

    it 'should send email' do
      expect { user.send_password_reset_email() }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it 'should reset_sent_at is not empty' do
      expect { user.send_password_reset_email() }.to change { user.reset_sent_at.nil? }.from(true).to(false)
    end

    it 'should send email for 1 second after' do
      user.send_password_reset_email()
      expect { user.send_password_reset_email() }.to change(ActionMailer::Base.deliveries, :count).by(0)
    end
  end

  describe 'create_digest(attribute)' do
    before { create(:user) }

    context 'activation_token' do
      it 'save activation digest in database for email confirm' do
        expect { user.create_digest(:activation) }.to change { user.activation_digest.is_a?(String) }.from(false).to(true)
      end
    end

    context 'reset_token' do
      it 'save reset digest in database for password reset' do
        expect { user.create_digest(:reset) }.to change { user.reset_digest.is_a?(String) }.from(false).to(true)
      end
    end
  end

  describe 'before_save downcase_email()' do
    before do
      user.email.upcase!
    end

    it 'should be downcase before saving user' do
      expect { user.save }.to change(user, :email).to(user.email.downcase)
    end
  end

  describe 'before_create create_activation_digest_before_create()' do
    it 'shoud create activation_digest' do
      expect { user.save! }.to change(user, :activation_digest)
    end

    context 'user activated is true' do
      before do
        user.activated = true
      end

      it 'no create activation_digest' do
        expect { user.save! }.not_to change(user, :activation_digest)
      end
    end
  end

  describe 'after_create create_profile_model()' do
    it 'should create profile model' do
      expect { user.save }.to change(Profile, :count).by(1)
    end

    context 'skip_create_profile_model is true' do
      before do
        user.skip_create_profile_model = true
      end

      it 'not create profile model' do
        expect { user.save }.not_to change(Profile, :count)
      end
    end
  end

  describe 'after_create send_account_activation_email()' do
    it 'should send activation email' do
      expect { user.save }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    context 'user activated is true' do
      before do
        user.activated = true
      end

      it 'no send activation email' do
        expect { user.save }.not_to change(ActionMailer::Base.deliveries, :count)
      end
    end
  end
end

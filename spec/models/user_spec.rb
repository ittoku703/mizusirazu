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
    it 'should be downcase before saving user' do
      upper_case_email = 'HOGE@BAR.COM'
      user.email = upper_case_email
      user.save
      expect(user.reload.email.downcase).to eq upper_case_email.downcase
    end

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

  describe 'password' do
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

  describe '.profile' do
    it 'should be delete when user destroyed' do
      user.save
      user.profile.save
      expect { user.destroy }.to change(Profile, :count).by(-1)
    end

    it 'should create after user created' do
      expect { user.save }.to change(Profile, :count).by(1)
    end
  end

  def user_valid?(user)
    expect(user).to be_valid
  end

  def user_invalid?(user)
    expect(user).not_to be_valid
  end
end

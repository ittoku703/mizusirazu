require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { build(:user) }
  valid_email_addresses   = %w[
    this_email_address@isvalid.com
    email0123@valid.com.com
    EMAIL0123@VALID.CO.JP
  ]
  invalid_email_addresses = %w[
    this-#email-is@invalid.com
    email0123@invalid
    email0123@invalid#hoge.com
  ]

  it 'is valid if name length is 4..99 characters' do
    user.name = "shinzanmono"
    expect(user).to be_valid
  end

  it 'is invalid if name length is 4 characters less' do
    user.name = "bar"
    expect(user).to be_invalid
  end

  it 'is invalid if name length is 99 characters more' do
    user.name = "x" * 100
    expect(user).to be_invalid
  end
  
  it 'is valid if email format is correct' do
    valid_email_addresses.each do |valid_email|
      user.email = valid_email
      expect(user).to be_valid
    end
  end

  it 'is invalid if email format is wrong' do
    invalid_email_addresses.each do |invalid_email|
      user.email = invalid_email
      expect(user).to be_invalid
    end
  end

  it 'is valid if password length is 6..128 characters' do
    user.password = 'password'
    expect(user).to be_valid
  end

  it 'is invalid if password length is 6 characters less' do
    user.password = "   "
    expect(user).to be_invalid
  end

  it 'is invalid if password length is 128 characters more' do
    user.password = "x" * 129
    expect(user).to be_invalid
  end

end

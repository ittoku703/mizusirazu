require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it 'should be valid' do
    expect(user).to be_valid
  end

  describe '.name' do
    it 'is invalid if name is empty' do
      user.name = ''
      expect(user).to be_invalid
    end

    it 'is invalid if name is longer then 20 characters' do
      user.name = 'X' * 51
      expect(user).to be_invalid
    end

    it 'is invalid if name is unknown characters' do
      names = [
        '新参者',
        ",./;\\\''",
        'アイウエオ'
      ]
      names.each do |name|
        user.name = name
        expect(user).to be_invalid, "invalid name #{user.name}"
      end
    end

    it 'is invalid if name is not unique' do
      dup_name = User.new(name: user.name, email: 'another@another.com', password: 'password')
      user.save
      expect(dup_name).to be_invalid
    end
  end

  describe '.email' do
    it 'is invalid if email is empty' do
      user.email = ''
      expect(user).to be_invalid
    end

    it 'is invalid if email is longer then 255 characters' do
      user.email = ('X' * 244).concat('@example.com')
      expect(user).to be_invalid
    end

    it 'is invalid if email is unknown characters' do
      emails = [
        '-=-aksdfjie@assdfnvk.-com',
        'email@invalid',
        'あいうえお@invalid.com'
      ]
      emails.each do |email|
        user.email = email
        expect(user).to be_invalid, "invalid email: #{user.email}"
      end
    end

    it 'is invalid if email is not unique' do
      dup_user = User.new(name: 'special_user', email: user.email, password: 'password')
      user.save
      expect(dup_user).to be_invalid
    end
  end

  describe '.password' do
    it 'is invalid if password is less then 6 characters' do
      user.password = 'hogehoge'
      user.password_confirmation = 'barbar'
      expect(user).to be_invalid
    end

    it 'is invalid if password is less then 6 characters' do
      user.password = user.password_confirmation = 'X' * 5
      expect(user).to be_invalid
    end

    it 'is invalid if password is longer then 128 characters' do
      user.password = user.password_confirmation = 'X' * 129
      expect(user).to be_invalid
    end

    it 'is timeout after 1 day' do
      user.save
      expect(user.timedout?(1.day.ago)).to eq true
    end
  end
end

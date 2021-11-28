require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it { expect(user.valid?).to eq true }

  describe 'profile' do
    it 'associated should be destroyed' do
      user.save
      user.create_profile!(name: 'test_name', bio: 'hello', location: 'ja')
      expect { user.destroy }.to change(Profile, :count).by(-1)
    end
  end

  describe 'microposts' do
    it 'associated should be destroyed' do
      user.save
      create(:micropost, user: user)
      expect { user.destroy }.to change(Micropost, :count).by(-1)
    end
  end

  describe 'comments' do
    it 'associated should be destroyed' do
      user.save
      micropost = create(:micropost, user: user)
      create(:comment, micropost: micropost, user: user)
      expect { user.destroy }.to change(Comment, :count).by(-1)
    end
  end
end

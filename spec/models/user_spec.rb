require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it { expect(user.valid?).to eq true }

  describe 'microposts' do
    it 'associated should be destroyed' do
      user.save
      user.microposts.create!(title: 'Title', content: 'Content')
      expect { user.destroy }.to change(Micropost, :count).by(-1)
    end
  end
end

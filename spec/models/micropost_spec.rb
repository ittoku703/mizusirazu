require 'rails_helper'

RSpec.describe Micropost, type: :model do
  subject(:valid) { micropost.valid? }

  let(:micropost) { build(:micropost) }

  it { is_expected.to eq true }

  describe 'title' do
    it 'is required' do
      micropost.title = nil
      expect(valid).to eq false
    end

    it 'is less than 100 characters' do
      micropost.title = 'x' * 101
      expect(valid).to eq false
    end
  end

  describe 'content' do
    it 'is required' do
      micropost.content = nil
      expect(valid).to eq false
    end

    it 'is less than 1000 characters' do
      micropost.content = 'x' * 1001
      expect(valid).to eq false
    end
  end

  describe 'comments' do
    it 'associated should be destroyed' do
      user = create(:user)
      micropost.save
      user.comments.create!(micropost_id: micropost.id, content: 'content')
      expect { micropost.destroy }.to change(Comment, :count).by(-1)
    end
  end
end

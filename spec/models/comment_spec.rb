require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:valid) { comment.valid? }

  let(:comment) { build(:comment) }

  it { is_expected.to eq true }

  describe 'content' do
    it 'is required' do
      comment.content = nil
      expect(valid).to eq false
    end

    it 'is less than 1000 characters' do
      comment.content = 'x' * 1001
      expect(valid).to eq false
    end
  end
end

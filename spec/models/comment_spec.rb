require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:comment) { build(:comment) }

  it { expect(comment).to be_valid }

  describe 'content' do
    it 'should be presense' do
      comment.content = ' '
      comment_invalid?()
    end

    it 'length should be 10000 less' do
      comment.content = 'x' * 10001
      comment_invalid?()
    end
  end

  def comment_valid?
    expect(comment).to be_valid
  end

  def comment_invalid?
    expect(comment).not_to be_valid
  end
end

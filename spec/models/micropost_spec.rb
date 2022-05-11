require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:micropost) { build(:micropost) }

  it { micropost_valid?() }

  describe 'title' do
    it 'should be presence' do
      micropost.title = ''
      micropost_invalid?()
    end

    it 'length should be 128 less' do
      micropost.title = 'a' * 129
      micropost_invalid?()
    end
  end

  describe 'content' do
    it 'should be presence' do
      micropost.content = ''
      micropost_invalid?()
    end

    it 'length should be 10000 less' do
      micropost.content = 'a' * 10001
      micropost_invalid?()
    end
  end

  describe 'comments' do
    before do
      micropost.save
      micropost.comments.create!(content: 'content', user_id: micropost.user.id)
    end

    it 'should be delete when user destroyed' do
      expect { micropost.destroy }.to change(Comment, :count).by(-1)
    end
  end

  def micropost_valid?
    expect(micropost).to be_valid
  end

  def micropost_invalid?
    expect(micropost).not_to be_valid
  end
end

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

  describe 'images' do
    it 'should be attached' do
      micropost.images.attach(io: File.open('spec/fixtures/files/test.png'), filename: 'test.png', content_type: 'image/png')
      expect(micropost.images.attached?).to eq true
    end
  end

  def micropost_valid?
    expect(micropost).to be_valid
  end

  def micropost_invalid?
    expect(micropost).not_to be_valid
  end
end

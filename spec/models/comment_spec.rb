require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:valid) { comment.valid? }

  let(:comment) { build(:comment) }

  it { is_expected.to eq true }

  describe 'micropost_id' do
    it 'is required' do
      comment.micropost_id = nil
      expect(valid).to eq false
    end
  end

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

  describe 'images' do
    it 'attached? is true' do
      uploaded_files = [
        fixture_file_upload('spec/factories/images/test.png'),
        fixture_file_upload('spec/factories/images/test.gif')
      ]
      comment.images = uploaded_files
      expect(valid).to eq true
    end

    it 'is false if the file extension is not png, gif, jpg' do
      comment.images = [fixture_file_upload('spec/factories/images/test.dds')]
      expect(valid).to eq false
    end

    it 'is false if the file size is 5 megabytes more' do
      comment.images = [fixture_file_upload('spec/factories/images/ten_megabytes.png')]
      expect(valid).to eq false
    end

    it 'is false if the 4 files selcted' do
      uploaded_files = []
      4.times do
        uploaded_files << fixture_file_upload('spec/factories/images/test.gif')
      end
      comment.images = uploaded_files
      expect(valid).to eq false
    end
  end
end

require 'rails_helper'

RSpec.describe Micropost, type: :model do
  subject(:valid) { micropost.valid? }

  let(:user) { create(:user) }
  let(:micropost) { build(:micropost, user: user) }

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

  describe 'images' do
    it 'attached? is true' do
      uploaded_files = [
        fixture_file_upload('spec/factories/images/test.png'),
        fixture_file_upload('spec/factories/images/test.gif')
      ]
      micropost.images = uploaded_files
      expect(valid).to eq true
    end

    it 'is false if the file extension is not png, gif, jpg' do
      micropost.images = [fixture_file_upload('spec/factories/images/test.dds')]
      expect(valid).to eq false
    end

    it 'is false if the file size is 5 megabytes more' do
      micropost.images = [fixture_file_upload('spec/factories/images/ten_megabytes.png')]
      expect(valid).to eq false
    end

    it 'is false if the 11 files selcted' do
      uploaded_files = []
      11.times do
        uploaded_files << fixture_file_upload('spec/factories/images/test.gif')
      end
      micropost.images = uploaded_files
      expect(valid).to eq false
    end
  end
end

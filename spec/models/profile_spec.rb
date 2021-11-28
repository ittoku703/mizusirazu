require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject(:valid) { profile.valid? }

  let(:profile) { build(:profile) }

  it { is_expected.to eq true }

  describe 'name' do
    it 'is false if length more than 100' do
      profile.name = 'x' * 101
      expect(valid).to eq false
    end

    it 'is true if name is nil' do
      profile.name = nil
      expect(valid).to eq true
    end
  end

  describe 'bio' do
    it 'is false if length more than 1000' do
      profile.bio = 'x' * 1001
      expect(valid).to eq false
    end

    it 'is true if name is nil' do
      profile.bio = nil
      expect(valid).to eq true
    end
  end

  describe 'location' do
    it 'is false if length more than 100' do
      profile.location = 'x' * 101
      expect(valid).to eq false
    end

    it 'is true if name is nil' do
      profile.location = nil
      expect(valid).to eq true
    end
  end
end

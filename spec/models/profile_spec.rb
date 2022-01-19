require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:profile) { build(:profile) }

  it { profile_valid?(profile) }

  describe '.name' do
    it 'length should be 128 less' do
      profile.name = 'a' * 129
      profile_invalid?(profile)
    end
  end

  describe '.bio' do
    it 'length should be 1024 less' do
      profile.bio = 'x' * 1025
      profile_invalid?(profile)
    end
  end

  describe '.location' do
    it 'length should be 128 less' do
      profile.location = 'x' * 129
      profile_invalid?(profile)
    end
  end

  def profile_valid?(profile)
    expect(profile).to be_valid
  end

  def profile_invalid?(profile)
    expect(profile).not_to be_valid
  end
end

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let!(:relationship) { build(:relationship) }

  it { relationship_valid?() }

  describe 'follower_id' do
    it 'presence true' do
      relationship.follower_id = nil
      relationship_invalid?()
    end
  end

  describe 'followed_id' do
    it 'presence true' do
      relationship.followed_id = nil
      relationship_invalid?()
    end
  end

  describe 'follower' do
    before do
      relationship.save()
    end

    it { expect(relationship.follower.class).to eq User }
  end

  describe 'followed' do
    before do
      relationship.save()
    end

    it { expect(relationship.followed.class).to eq User }
  end

  def relationship_valid?()
    expect(relationship).to be_valid()
  end

  def relationship_invalid?()
    expect(relationship).not_to be_valid()
  end
end

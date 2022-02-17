require 'rails_helper'

RSpec.describe Provider, type: :model do
  describe 'Provider.find_or_create_from_auth(auth)' do
    context 'provider is found' do
      let(:provide_user) { Provider.find_or_create_from_auth(twitter_mock) }

      it 'return provider user' do
        expect(Provider.find_or_create_from_auth(twitter_mock)).to eq provide_user
      end
    end

    context 'provider is not found' do
      it 'user created' do
        expect { Provider.find_or_create_from_auth(twitter_mock) }.to change(User, :count).by(1)
      end

      it 'provider created' do
        expect { Provider.find_or_create_from_auth(twitter_mock) }.to change(Profile, :count).by(1)
      end

      it 'return provider user' do
        expect(Provider.find_or_create_from_auth(twitter_mock)).to eq User.last
      end
    end
  end
end

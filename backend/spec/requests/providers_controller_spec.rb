require 'rails_helper'

RSpec.describe ProvidersController, type: :request do
  describe 'GET /auth/twitter/callback' do
    context 'valid params' do
      before do
        twitter_mock()
        get provider_callback_path(provider: 'twitter')
      end

      it 'redirect to root' do
        expect(response).to redirect_to root_path()
      end

      it 'logged in user' do
        expect(is_logged_in?).to eq true
      end
    end

    context 'invalid params' do
      before do
        twitter_invalid_credentials()
        get provider_callback_path(provider: 'twitter')
      end

      it 'no logged in user' do
        expect(is_logged_in?).to eq false
      end
    end
  end

  describe 'GET /auth/github/callback' do
    context 'valid params' do
      before do
        github_mock()
        get provider_callback_path(provider: 'github')
      end

      it 'redirect to root' do
        expect(response).to redirect_to root_path()
      end

      it 'logged in user' do
        expect(is_logged_in?).to eq true
      end
    end

    context 'invalid params' do
      before do
        github_invalid_credentials()
        get provider_callback_path(provider: 'github')
      end

      it 'no logged in user' do
        expect(is_logged_in?).to eq false
      end
    end
  end

  describe 'GET /auth/failure' do
    before do
      get provider_failure_path()
    end

    it 'redirect to root' do
      expect(response).to redirect_to root_path
    end
  end
end

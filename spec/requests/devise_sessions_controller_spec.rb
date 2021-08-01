require 'rails_helper'
RSpec.describe "Devise::SessionsController", type: :request do
  let!(:valid_params)   { attributes_for(:user) }
  let!(:invalid_params) { attributes_for(:user, email: '', password: '') }
  # =====================================================================================
  # routing
  # new_user_session     GET    /login(.:format)  devise/sessions#new
  # user_session         POST   /login(.:format)  devise/sessions#create
  # destroy_user_session DELETE /logout(.:format) devise/sessions#destroy
  #
  describe 'GET /login' do
    it 'request success' do
      get new_user_session_path
      expect(response.status).to eq 200
    end
  end

  describe 'POST /login' do
    let!(:user) { create(:user) }

    context 'valid_params' do
      before do
        post user_session_path, params: { user: valid_params }
      end

      it 'request status is Found' do
        expect(response.status).to eq 302
      end

      it 'redirect to user page' do
        expect(response).to redirect_to user_path
      end
    end

    context 'invalid params' do
      before do
        post user_session_path, params: { user: invalid_params }
      end

      it 'request status is OK' do
        expect(response.status).to eq 200
      end

      it 'display error message' do
        expect(response.body).to include 'Invalid Email or password.'
      end
    end
  end

  describe 'DELETE /logout' do
  end
end

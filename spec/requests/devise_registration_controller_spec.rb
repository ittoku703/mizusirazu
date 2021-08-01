require 'rails_helper'

RSpec.describe "Devise::RegistrationsController", type: :request do
  let!(:valid_params)   { attributes_for(:user) }
  let!(:invalid_params) { attributes_for(:user, name: " ") }

  describe "GET /signup" do
    it 'request success' do
      get new_user_registration_path
      expect(response.status).to eq 200
    end
  end

  describe 'GET /settings' do
    context 'non-logged-in user' do
      it 'request failed and redirect to login page' do
        get edit_user_registration_path
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context 'logged-in user' do

      it 'request success' do
        login_as(create(:user))
        get edit_user_registration_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET /signup/cancel' do
    context 'non-logged-in user' do
      it 'request failed and redirect to signup page' do
        get cancel_user_registration_path
        expect(response).to redirect_to(new_user_registration_url)
      end
    end

    context 'logged-in user' do
      it 'redirect to user page' do
        login_as(create(:user))
        get cancel_user_registration_path
        expect(response).to redirect_to(user_url)
      end
    end
  end

  describe 'POST /users' do
    context 'valid params' do
      before do
        post user_registration_path, params: { user: valid_params }
      end

      it 'success request' do
        expect(response.status).to eq 302
      end

      it 'send confirm email' do
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      it 'created user' do
        expect(User.count).to eq 1
      end

      it 'redirect to root' do
        expect(response).to redirect_to root_url
      end
    end

    context 'invalid params' do
      before do
        post user_registration_path, params: { user: invalid_params }
      end

      it 'request status is OK' do
        expect(response.status).to eq 200
      end

      it 'no send confirm email' do
        expect(ActionMailer::Base.deliveries.size).to eq 0
      end

      it 'no created user' do
        change(User, :count).by 0
      end

      it 'display error messages' do
        expect(response.body).to include 'prohibited this user from being saved'
      end
    end
  end

  describe 'PATCH /users' do
    let(:valid_params)   { attributes_for(:user, current_password: 'password') }
    let(:invalid_params) { attributes_for(:user, current_password: '') }

    it 'redirect login page when non-logged-in user' do
      patch users_path, params: { user: valid_params }
      expect(response).to redirect_to new_user_session_path
    end

    context 'valid params' do
      before do
        login_as(create(:user))
        patch users_path, params: { user: valid_params }
      end

      it 'request success' do
        expect(response.status).to eq 302
      end

      it 'redirect root' do
        expect(response).to redirect_to root_url
      end

    end

    context 'invalid params' do
      before do
        login_as(create(:user))
        patch users_path, params: { user: invalid_params }
      end

      it 'request success' do
        expect(response.status).to eq 200
      end

      it 'display error message' do
        expect(response.body).to include'prohibited this user from being saved:'
      end
    end
  end

  describe 'DELETE /users' do
    context 'non-logged-in user' do
      it 'redirect login' do
        delete users_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'logged-in user' do
      before do
        login_as(create(:user))
      end

      it 'deleted user' do
        expect { delete users_path }.to change(User, :count).by -1
      end

      it 'redirect root' do
        delete users_path
        expect(response).to redirect_to root_url
      end
    end
  end
end

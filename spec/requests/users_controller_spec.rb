require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let(:valid_params) { attributes_for(:user) }
  let(:invalid_params) { attributes_for(:user, email: '') }

  describe 'GET /users' do
    it 'return status 401(Unauthorized)' do
      get users_path
      expect(response.status).to eq 401
    end
  end

  describe 'GET /users/:id' do
    it 'is OK' do
      get user_path(user)
      expect(response.status).to eq 200
    end
  end

  describe 'GET /signup' do
    context 'when logged in user' do
      it 'is redirect to root' do
        logged_in_user
        get new_user_path
        expect(response).to redirect_to root_url
      end
    end

    context 'when not logged in user' do
      it 'is OK' do
        get new_user_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET /settings' do
    context 'when logged in user' do
      it 'is OK' do
        logged_in_user
        get edit_user_path
        expect(response.status).to eq 200
      end
    end

    context 'when not logged in user' do
      it 'is redirect to login page' do
        get edit_user_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST /users' do
    context 'when params is valid' do
      before do
        post users_path, params: { user: valid_params }
      end

      it 'is redirect to root' do
        expect(response).to redirect_to root_url
      end

      it 'is sending activation email' do
        expect(ActionMailer::Base.deliveries.count).to eq 1
      end
    end

    context 'when params is invalid' do
      before do
        post users_path, params: { user: invalid_params }
      end

      it 'is 422(Unauthorized) status' do
        expect(response.status).to eq 422
      end

      it 'is rollback' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH/PUT /users/:id' do
    context 'when logged in user and valid params' do
      it 'is redirect to show page' do
        logged_in_user
        patch user_path(user), params: { user: valid_params }
        expect(response).to redirect_to user_path(user)
      end
    end

    context 'when logged in user and invalid params' do
      it 'is rallback' do
        logged_in_user
        patch user_path(user), params: { user: invalid_params }
        expect(response).to render_template :edit
      end
    end

    context 'when non logged in user' do
      it 'is redirect to login page' do
        patch user_path(user), params: { user: valid_params }
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe 'DELETE /users/:id' do
    context 'when logged in user' do
      before do
        logged_in_user
        delete user_path(user)
      end

      it 'is redirect to root' do
        expect(response).to redirect_to root_url
      end
    end

    context 'when not logged in user' do
      before do
        delete user_path(user)
      end

      it 'is redirect to login page' do
        expect(response).to redirect_to new_user_session_url
      end
    end

    context 'when admin user' do
      before do
        logged_in_admin
        delete user_path(user)
      end

      it 'is redirect to root' do
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'GET /users/:id/activate' do
    it 'is redirect to root' do
      expect { get activate_user_path(user) }.to raise_error NoMethodError
    end
  end
end

require 'rails_helper'

RSpec.describe UserSessionsController, type: :request do
  let(:user) { create(:user) }

  describe 'GET /login' do
    context 'when logged in user' do
      it 'is redirect to root' do
        logged_in_user
        get new_user_session_path
        expect(response).to redirect_to root_url
      end
    end

    context 'when non logged in user' do
      it 'is OK' do
        get new_user_session_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST /login' do
    before do
      user.activate!
    end

    context 'when valid params' do
      it 'is redirect to user page' do
        post user_sessions_path, params: { email: user.email, password: 'password', remember: 'on' }
        expect(response).to redirect_to user_path(user)
      end
    end

    context 'when invalid params' do
      it 'is rollback' do
        post user_sessions_path, params: { email: 'hogehoge', password: 'password', remember: 'on' }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE /logout' do
    context 'when logged in user' do
      it 'is redirect to root' do
        logged_in_user
        delete user_session_path
        expect(response).to redirect_to root_url
      end
    end

    context 'when non logged in user' do
      it 'is redirect login page' do
        delete user_session_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end

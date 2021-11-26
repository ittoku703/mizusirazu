require 'rails_helper'

RSpec.describe Users::SessionsController, type: :request do
  let(:user) { create(:user, confirmed_at: Time.zone.now) }

  describe 'GET /login' do
    context 'when logged in user' do
      it 'is redirect to root' do
        login_user
        get new_user_session_path
        expect(response).to redirect_to root_path
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
    context 'when valid params' do
      it 'is redirect_to root' do
        post user_session_path, params: {
          user: {
            email: user.email,
            password: 'password'
          },
          remember: '1'
        }
        expect(response).to redirect_to root_path
      end
    end

    context 'when invalid params' do
      it 'is rollback' do
        post user_session_path, params: {
          user: {
            email: 'hoge',
            password: 'hogehoge'
          },
          remember: '1'
        }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE /logout' do
    it 'is redirect_to root' do
      delete destroy_user_session_path
      expect(response).to redirect_to root_path
    end
  end
end

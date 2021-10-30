require 'rails_helper'

RSpec.describe PasswordsController, type: :request do
  let(:user) { create(:user, confirmed_at: Time.zone.now) }

  describe 'GET /password/new' do
    context 'when logged in user' do
      it 'is redirect_to root' do
        login_user
        get new_user_password_path
        expect(response).to redirect_to root_path
      end
    end

    context 'when non logged in user' do
      it 'is OK' do
        get new_user_password_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST /password' do
    context 'when valid params' do
      it 'is redirect_to login page' do
        post user_password_path, params: { user: { email: user.email } }
        expect(response).to redirect_to new_user_session_path
      end

      it 'sending password reset email' do
        post user_password_path, params: { user: { email: user.email } }
        expect(ActionMailer::Base.deliveries.count).to eq 1
      end
    end

    context 'when invalid params' do
      it 'is rollback' do
        post user_password_path, params: { user: { email: '' } }
        expect(response).to render_template :new
      end

      it 'no sending password reset email' do
        post user_password_path, params: { user: { email: 'hoge' } }
        expect(ActionMailer::Base.deliveries.count).to eq 0
      end
    end
  end

  describe 'GET /password/edit?reset_password_token=abcdef' do
    context 'when valid or invalid reset_password_token' do
      it 'is OK' do
        post user_password_path, params: { user: { email: user.email } } # create reset_password_token
        get '/password/edit?reset_password_token=hogehoge'
        expect(response.status).to eq 200
      end
    end

    context 'when no reset_password_token' do
      it 'redirect_to login page' do
        get edit_user_password_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end

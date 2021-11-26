require 'rails_helper'

RSpec.describe Users::ConfirmationsController, type: :request do
  let(:user) { create(:user) }

  describe 'GET /confirmation/new' do
    context 'when logged in user' do
      it 'redirect to root' do
        login_user
        get new_user_confirmation_path
        expect(response).to redirect_to root_path
      end
    end

    context 'when non logged in user' do
      it 'is OK' do
        get new_user_confirmation_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST /confirmation' do
    context 'when valid params' do
      it 'redirect to login page' do
        post user_confirmation_path, params: { user: { email: user.email } }
        expect(response).to redirect_to new_user_session_path
      end

      it 'sending confirmation email' do
        post user_confirmation_path, params: { user: { email: user.email } }
        expect(ActionMailer::Base.deliveries.count).to eq 2
      end
    end

    context 'when invalid params' do
      it 'is rollback' do
        post user_confirmation_path, params: { user: { email: 'hogehoge' } }
        expect(response).to render_template :new
      end

      it 'no sending confirmation email' do
        post user_confirmation_path, params: { user: { email: 'hogehoge' } }
        expect(ActionMailer::Base.deliveries.count).to eq 0
      end
    end
  end

  describe 'GET /confirmation?confirmation_token=abcdef' do
    context 'when valid confirmation_token' do
      it 'redirect to user page' do
        get "/confirmation?confirmation_token=#{user.confirmation_token}"
        expect(response).to redirect_to user_profile_path(user)
      end
    end

    context 'when invalid confirmation_token' do
      it 'render new' do
        get '/confirmation?confirmation_token=abcdef'
        expect(response).to render_template :new
      end
    end
  end
end

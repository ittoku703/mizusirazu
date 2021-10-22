require 'rails_helper'

RSpec.describe PasswordResetsController, type: :request do
  let(:user) { create(:user) }

  describe 'GET /password/new' do
    context 'when logged in user' do
      it 'is redirect to root' do
        logged_in_user
        get new_password_reset_path
        expect(response).to redirect_to root_url
      end
    end

    context 'when non logged in user' do
      it 'is OK' do
        get new_password_reset_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST /password' do
    context 'when valid params' do
      before do
        post password_resets_path, params: { email: user.email }
      end

      it 'is redirect to root' do
        expect(response).to redirect_to root_url
      end

      # text and html email send
      it 'is sending password reset email' do
        expect(ActionMailer::Base.deliveries.count).to eq 2
      end
    end

    context 'when invalid params' do
      before do
        post password_resets_path, params: { email: 'hogehoge' }
      end

      it 'is redirect to root' do
        expect(response).to render_template :new
      end

      it 'is not sending password reset email' do
        expect(ActionMailer::Base.deliveries.count).to eq 0
      end
    end
  end

  describe 'GET /password/:id/edit' do
    # created user.reset_password_token
    before do
      user.deliver_reset_password_instructions!
    end

    context 'when logged in user' do
      it 'is redirect root' do
        logged_in_user
        get edit_password_reset_path(user.reset_password_token)
        expect(response).to redirect_to root_url
      end
    end

    context 'when non logged in user' do
      it 'is OK' do
        get edit_password_reset_path(user.reset_password_token)
        expect(response.status).to eq 200
      end
    end

    context 'when invalid params' do
      it 'is ???' do
        get edit_password_reset_path('hogehoge')
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH/PUT /password/:id' do
    # created user.reset_password_token
    before do
      user.deliver_reset_password_instructions!
    end

    context 'when valid params' do
      it 'is redirect to root' do
        patch password_reset_path(user.reset_password_token), params: {
          password: 'password',
          password_confirmation: 'password'
        }
        expect(response).to redirect_to root_url
      end
    end

    context 'when invalid params' do
      it 'is rollback' do
        patch password_reset_path(user.reset_password_token), params: {
          password: 'hogehoge',
          password_confirmation: ''
        }
        expect(response).to render_template :edit
      end
    end

    context 'when logged in user' do
      it 'is redirect root' do
        logged_in_user
        patch password_reset_path(user.reset_password_token), params: {
          password: 'password',
          password_confirmation: 'password'
        }
        expect(response).to redirect_to root_url
      end
    end
  end
end

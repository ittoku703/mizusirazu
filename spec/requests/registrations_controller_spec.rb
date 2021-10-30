require 'rails_helper'

RSpec.describe RegistrationsController, type: :request do
  let(:user) { create(:user) }

  describe 'GET /signup' do
    context 'when logged in user' do
      it 'is redirect to root' do
        login_user
        get signup_path
        expect(response).to redirect_to root_path
      end
    end

    context 'when non logged in user' do
      it 'is OK' do
        get signup_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST /users' do
    context 'when valid params' do
      it 'is redirect to root' do
        post user_registration_path, params: {
          user: {
            email: 'user@valid.com',
            password: 'password',
            password_confirmation: 'password'
          }
        }
        expect(response).to redirect_to root_path
      end

      it 'is sending confirmation email' do
        post user_registration_path, params: {
          user: {
            email: 'user@valid.com',
            password: 'password',
            password_confirmation: 'password'
          }
        }
        expect(ActionMailer::Base.deliveries.count).to eq 1
      end
    end

    context 'when invalid params' do
      it 'is rollback' do
        post user_registration_path, params: {
          user: {
            email: '',
            password: '',
            password_confirmation: ''
          }
        }
        expect(response).to render_template :new
      end

      it 'is not sending email' do
        post user_registration_path, params: {
          user: {
            email: '',
            password: '',
            password_confirmation: ''
          }
        }
        expect(ActionMailer::Base.deliveries.count).to eq 0
      end
    end
  end

  describe 'GET /users/:id' do
    context 'when exist id' do
      it 'is OK' do
        get user_profile_path(user)
        expect(response.status).to eq 200
      end
    end

    context 'when non exist id' do
      it 'is NOT FOUND' do
        get user_profile_path('hoge')
        expect(response.status).to eq 404
      end
    end
  end

  describe 'GET /settings' do
    context 'when logged in user' do
      it 'is OK' do
        login_user
        get settings_path
        expect(response.status).to eq 200
      end
    end

    context 'when non logged in user' do
      it 'is redirect to login page' do
        get settings_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PUT /users' do
    before { login_user }

    context 'when valid params' do
      it 'is redirect to profile page' do
        put user_registration_path, params: {
          user: {
            email: user.email,
            password: 'new_password',
            password_confirmation: 'new_password',
            current_password: 'password'
          }
        }
        expect(response).to redirect_to settings_path
      end
    end

    context 'when invalid params' do
      it 'is rollback' do
        put user_registration_path, params: {
          user: {
            email: 'hoge',
            password: 'foo',
            password_confirmation: 'bar',
            current_password: 'baz'
          }
        }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE /users' do
    context 'when logged in user' do
      it 'is redirect to root' do
        login_user
        delete user_registration_path
        expect(response).to redirect_to root_path
      end

      it 'is number of User -1' do
        login_user
        expect { delete user_registration_path }.to change(User, :count).by(-1)
      end
    end

    context 'when non logged in user' do
      it 'is redirect to login page' do
        delete user_registration_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  # describe 'GET /users/cancel' do
  # end
end

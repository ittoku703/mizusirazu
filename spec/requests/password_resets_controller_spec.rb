require 'rails_helper'

RSpec.describe PasswordResetsController, type: :request do
  let(:user) { create(:user) }

  describe 'GET /passwords/new' do

    context 'non logged in user' do
      before do
        get new_password_reset_path
      end
      it 'returns http success' do
        expect(response).to have_http_status 200
      end
    end

    context 'logged in user' do
      before do
        log_in_as(user)
        get new_password_reset_path
      end
      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST /passwords' do
    context 'valid params' do
      before do
        activate_as(user)
        post password_resets_path, params: { password_reset: { email: user.email } }
        sleep 1 # because can not send an email twice in one second.
      end
      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end
      it 'send email' do
        expect {
          post password_resets_path, params: { password_reset: { email: user.email } }
        }.to change(ActionMailer::Base.deliveries, :count).by(1)
      end
    end

    context 'invalid params' do
      before do
        activate_as(user)
        post password_resets_path, params: { password_reset: { email: 'hogehoge' } }
      end
      it 'render :new' do
        expect(response).to render_template :new
      end
    end

    context 'logged in user' do
      before do
        log_in_as(user)
        post password_resets_path, params: { password_reset: { email: user.email } }
      end
      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end
    end

    context 'non activate user' do
      before do
        post password_resets_path, params: { password_reset: { email: user.email } }
      end
      it 'redirect to confirms form' do
        expect(response).to redirect_to new_account_activation_path
      end
    end

    context 'reCAPTCHA' do
      before do
        allow_any_instance_of(Recaptcha::Adapters::ControllerMethods).to receive(:verify_recaptcha).and_return(false)
        post password_resets_path, params: { password_reset: { email: user.email } }
      end

      it 'render :new' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET /passwords/:id/edit' do
    context 'valid params' do
      before do
        activate_as(user)
        user.create_digest(:reset)
        get edit_password_reset_path(user.reset_token), params: { email: user.email }
      end
      it 'returns http success' do
        expect(response).to have_http_status 200
      end
    end

    context 'invalid params' do
      before do
        activate_as(user)
        user.create_digest(:reset)
        get edit_password_reset_path(user.reset_token), params: { email: 'hogehoge' }
      end
      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end
    end

    context 'logged in user' do
      before do
        log_in_as(user)
        user.create_digest(:reset)
        get edit_password_reset_path(user.reset_token), params: { email: user.email }
      end
      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end
    end

    context 'non activate user' do
      before do
        user.create_digest(:reset)
        get edit_password_reset_path(user.reset_token), params: { email: user.email }
      end
      it 'redirect to confirms form' do
        expect(response).to redirect_to new_account_activation_path
      end
    end
  end

  describe 'PATCH /passwords/:id' do
    let(:valid_params) { { password: 'new_password', password_confirmation: 'new_password' } }
    let(:invalid_params) { { password: 'barhogehgoeg', password_confirmation: 'bazhogehogeg' } }

    context 'valid params' do
      before do
        activate_as(user)
        user.create_digest(:reset)
        patch password_reset_path(user.reset_token), params: { user: valid_params, email: user.email }
      end
      it 'redirect to login page' do
        expect(response).to redirect_to new_session_path
      end
    end

    context 'invalid params' do
      before do
        activate_as(user)
        user.create_digest(:reset)
        patch password_reset_path(user.reset_token), params: { user: invalid_params, email: user.email }
      end
      it 'render :new' do
        expect(response).to render_template :new
      end
    end

    context 'logged in user' do
      before do
        log_in_as(user)
        user.create_digest(:reset)
        patch password_reset_path(user.reset_token), params: { user: valid_params, email: user.email }
      end
      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end
    end

    context 'non activate user' do
      before do
        user.create_digest(:reset)
        patch password_reset_path(user.reset_token), params: { user: valid_params, email: user.email }
      end
      it 'redirect to confirms form' do
        expect(response).to redirect_to new_account_activation_path
      end
    end
  end
end

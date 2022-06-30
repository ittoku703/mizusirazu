require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  let(:user) { create(:user) }
  let(:valid_params) { { name_or_email: user.name, password: 'password', remember_me: '1' } }
  let(:invalid_params) { { name_or_email: 'invalid', password: 'foobar' } }

  describe 'GET /login' do
    context 'non logged in user' do
      it 'should be success' do
        get new_session_path
        expect(response).to have_http_status 200
      end
    end

    context 'logged in user' do
      before do
        log_in_as(user)
      end

      it 'should redirect to root' do
        get new_session_path
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST /sessions' do
    context 'valid params' do
      before do
        activate_as(user)
        post sessions_path, params: { session: valid_params }
      end

      it 'should redirect to user page' do
        expect(response).to redirect_to user_path(user)
      end

      it 'should logged in' do
        expect(is_logged_in?).to eq true
      end

      it 'should be remember' do
        expect(cookies[:user_id].is_a?(String)).to eq true
      end
    end

    context 'invalid params' do
      before do
        post sessions_path, params: { session: invalid_params }
      end

      it 'render :new' do
        expect(response).to render_template :new
      end
    end

    context 'logged in user' do
      before { log_in_as(user) }

      it 'should redirect to root' do
        post sessions_path, params: { session: valid_params }
        expect(response).to redirect_to root_path
      end
    end

    context 'reCAPTCHA' do
      before do
        allow_any_instance_of(Recaptcha::Adapters::ControllerMethods).to receive(:verify_recaptcha).and_return(false)
        post sessions_path, params: { session: valid_params }
      end

      it 'render :new' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE /logout' do
    context 'logged in user' do
      before { log_in_as(user) }

      it 'should redirect to root' do
        delete session_path(user)
        expect(response).to redirect_to root_path
      end

      it 'should logged out' do
        delete session_path(user)
        expect(is_logged_in?).to eq false
      end
    end

    context 'non logged in user' do
      it 'should redirect to root' do
        delete session_path(user)
        expect(response).to redirect_to root_path
      end
    end
  end
end

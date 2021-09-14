require 'rails_helper'

RSpec.describe Users::SessionsController, type: :request do
  let(:user) { create(:user) }

  describe 'GET /login' do
    subject { get new_user_session_path }

    context 'logged-in' do
      before { login_user }
      it { is_expected.to redirect_to root_url }
    end

    context 'non-logged-in' do
      it { is_expected.to eq 200 }
    end
  end

  describe 'POST /login' do
    let(:user_params) { attributes_for(:user) }
    subject { post user_session_path, params: { user: { email: user.email, password: user.password } } }

    context 'valid params' do
      it { is_expected.to redirect_to root_url }
    end

    context 'invalid params' do
      subject { post user_session_path, params: { user: {} } }
      it { is_expected.to eq 200 }
    end
  end

  describe 'DELETE /logout' do
    subject { delete destroy_user_session_path }

    context 'non-logged-in' do
      it { is_expected.to redirect_to root_url }
    end

    context 'logged-in' do
      it { is_expected.to redirect_to root_url }
    end
  end
end

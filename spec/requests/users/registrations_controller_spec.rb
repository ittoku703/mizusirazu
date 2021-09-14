require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :request do
  describe 'GET /signup' do
    subject { get new_user_registration_path }
    context 'logged-in' do
      before { login_user }
      it { is_expected.to redirect_to root_url }
    end

    context 'non-logged-in' do
      it { is_expected.to eq 200 }
    end
  end

  describe 'POST /signup' do
    let(:user_params) { attributes_for(:user) }
    subject { post user_registration_path, params: { user: user_params } }

    context 'valid params' do
      it { is_expected.to eq 302 }
      it { expect { subject }.to change(User, :count).by(1) }
      it { is_expected.to redirect_to root_url }
    end

    context 'invalid params' do
      subject { post user_registration_path, params: { user: {} } }
      it { is_expected.to eq 200 }
      it { expect { subject }.to change(User, :count).by(0) }
    end

    context 'logged-in' do
      before { login_user }
      it { is_expected.to redirect_to root_url }
    end
  end

  describe 'GET /user' do
    subject { get user_path }

    context 'logged-in' do
      before { login_user }
      it { is_expected.to eq 200 }
    end

    context 'non-logged-in' do
      it { is_expected.to redirect_to root_url }
    end
  end

  describe 'GET /settings' do
    subject { get edit_user_registration_path }

    context 'logged-in' do
      before { login_user }
      it { is_expected.to eq 200 }
    end

    context 'non-logged' do
      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'PUT /' do
    let(:update_params) { attributes_for(:user, current_password: 'password') }
    subject { put user_registration_path, params: { user: update_params } }

    context 'valid params' do
      before { login_user }
      it { is_expected.to eq 302 }
    end
  end

  describe 'DELETE /' do
    subject { delete user_registration_path }
    context 'logged-in' do
      before { login_user }
      it { expect { subject }.to change(User, :count).by(-1) }
      it { is_expected.to redirect_to root_url }
    end

    context 'non-logged-in' do
      it { is_expected.to redirect_to new_user_session_path }
    end
  end
end

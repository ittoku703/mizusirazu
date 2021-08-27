require 'rails_helper'

RSpec.describe "Users::PasswordsControllers", type: :request do
  let(:user) { create(:user) }

  describe "GET /password/new" do
    subject { get new_user_password_path }
    context 'logged-in' do
      login_user
      it { is_expected.to redirect_to root_url }
    end

    context "non-logged-in" do
      it { is_expected.to eq 200 }
    end
  end

  describe 'POST /password' do
    context 'valid params' do
      subject { post user_password_path, params: { user: { email: user.email } } }
      it { is_expected.to redirect_to new_user_session_path }
      it { expect{subject}.to change{ ActionMailer::Base.deliveries.size}.by(1) }
    end

    context 'invalid params' do
      subject { post user_password_path, params: { user: {} } }
      it { is_expected.to render_template(:new) }
    end
  end

  describe 'GET /password/edit?reset_password_token=abcdef' do
    subject { get edit_user_password_path }
    context 'logged-in' do
      login_user
      it { is_expected.to redirect_to root_url }
    end

    context 'non-logged-in' do
      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'PUT /password' do
    context 'valid params' do
      subject { put user_password_path, params: { user: attributes_for(:user) } }
      it { is_expected.to eq 200 }
    end

    context 'invalid params' do
    end
  end
end

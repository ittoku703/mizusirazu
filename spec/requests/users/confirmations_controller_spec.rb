require 'rails_helper'

RSpec.describe Users::ConfirmationsController, type: :request do
  let(:user) { create(:user, confirmed_at: nil) }
  describe 'GET /verification/new' do
    subject { get new_user_confirmation_path }
    it { is_expected.to eq 200 }
  end

  describe 'POST /verification' do
    subject { post user_confirmation_path, params: { user: { email: user.email } } }
    it { is_expected.to redirect_to new_user_session_path }
    it { expect{subject}.to change{ActionMailer::Base.deliveries.size}.by(2) }
  end

  describe 'GET /verification?confirmation_token=abcdef' do
  end
end

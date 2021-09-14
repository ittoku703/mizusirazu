require 'rails_helper'

RSpec.describe Users::UnlocksController, type: :request do
  let(:user) { create(:user, locked_at: Time.zone.now) }
  describe 'GET /unlock/new' do
    subject { get new_user_unlock_path }
    it { is_expected.to eq 200 }
  end

  describe 'POST /unlock' do
    subject { post user_unlock_path, params: { user: { email: user.email } } }
    it { is_expected.to redirect_to new_user_session_path }
    it { expect { subject }.to change { ActionMailer::Base.deliveries.size }.by(1) }
  end
end

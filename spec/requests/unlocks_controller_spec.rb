require 'rails_helper'

RSpec.describe UnlocksController, type: :request do
  let(:user) { create(:user, confirmed_at: Time.zone.now) }

  describe 'GET /unlock/new' do
    context 'when logged in user' do
      it 'redirect to root' do
        login_user
        get new_user_unlock_path
        expect(response).to redirect_to root_path
      end
    end

    context 'when non logged in user' do
      it 'is OK' do
        get new_user_unlock_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST /unlock' do
    before do
      user.lock_access! # user lock!!
      ActionMailer::Base.deliveries.clear # clear email
    end

    context 'when valid params' do
      it 'redirect to root' do
        post user_unlock_path, params: { user: { email: user.email } }
        expect(response).to redirect_to new_user_session_path
      end

      it 'sending unlock email' do
        post user_unlock_path, params: { user: { email: user.email } }
        expect(ActionMailer::Base.deliveries.count).to eq 1
      end
    end

    context 'when non logged in user' do
      it 'is rollback' do
        post user_unlock_path, params: { user: { email: 'hoge' } }
        expect(response).to render_template :new
      end

      it 'no sending email' do
        post user_unlock_path, params: { user: { email: 'hoge' } }
        expect(ActionMailer::Base.deliveries.count).to eq 0
      end
    end
  end
end

require 'rails_helper'

RSpec.describe UserActivationsController, type: :request do
  let(:user) { create(:user) }

  describe 'GET /activate/new' do
    context 'when logged in user' do
      it 'redirect to root' do
        logged_in_user
        get new_user_activation_path
        expect(response).to redirect_to root_url
      end
    end

    context 'when non logged in user' do
      it 'is OK' do
        get new_user_activation_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST /activate' do
    context 'when valid params' do
      it 'redirect to root' do
        post user_activations_path, params: { email: user.email, password: 'password' }
        expect(response).to redirect_to root_url
      end

      it 'sending activation email' do
        post user_activations_path, params: { email: user.email, password: 'password' }
        expect(ActionMailer::Base.deliveries.count).to eq 2
      end
    end

    context 'when invalid params' do
      it 'is rollback' do
        post user_activations_path, params: { email: 'hogehoge', password: '' }
        expect(response).to render_template :new
      end
    end
  end
end

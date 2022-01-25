require 'rails_helper'

RSpec.describe AccountActivationsController, type: :request do
  let(:user) { create(:user) }

  describe 'GET /confirms/new' do
    context 'non confirmed user' do
      before do
        get new_account_activation_path
      end

      it 'should be success' do
        expect(response).to have_http_status 200
      end
    end

    context 'confirmed user' do
      before do
        log_in_as(user)
        get new_account_activation_path
      end

      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST /confirms' do
    context 'valid params' do
      before do
        post account_activations_path, params: { account_activation: { email: user.email } }
      end

      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end

      it 'should send account activation mail' do
        expect {
          post account_activations_path, params: { account_activation: { email: user.email } }
        }.to change(ActionMailer::Base.deliveries, :count).by(1)
      end
    end

    context 'invalid params' do
      before do
        post account_activations_path, params: { account_activation: { email: 'hogehoge' } }
      end

      it 'render :new' do
        expect(response).to render_template :new
      end
    end

    context 'confirmed user' do
      before do
        activate_as(user)
        post account_activations_path, params: { account_activation: { email: user.email } }
      end

      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET /confirms/:id/edit' do
    context 'valid params' do
      before do
        get edit_account_activation_path(user.activation_token), params: { email: user.email }
      end

      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end

      it 'should be user activated' do
        expect(user.reload.activated?).to eq true
      end

      it 'should be user logged in' do
        expect(is_logged_in?).to eq true
      end
    end

    context 'invalid params' do
      before do
        get edit_account_activation_path('hogehoge'), params: { email: user.email }
      end

      it 'redirect to confirm new' do
        expect(response).to redirect_to new_account_activation_path
      end
    end

    context 'confirmed user' do
      before do
        activate_as(user)
        get edit_account_activation_path(user.activation_token), params: { email: user.email }
      end

      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end
    end
  end
end

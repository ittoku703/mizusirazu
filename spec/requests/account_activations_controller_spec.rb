require 'rails_helper'

RSpec.describe AccountActivationsController, type: :request do
  let(:user) { create(:user) }

  describe 'GET /confirms/new' do
    context 'non confirmed user' do
      it 'should be success' do
        get new_account_activation_path
        expect(response).to have_http_status 200
      end
    end

    context 'confirmed user' do
      before { log_in_as(user); user.activate; }

      it 'redirect to root' do
        get new_account_activation_path
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST /confirms' do
    context 'valid params' do
      it 'redirect to root' do
        post account_activations_path, params: { account_activation: { email: user.email } }
        expect(response).to redirect_to root_path
      end

      # it 'should send account activation mail' do
      #   expect {
      #     post account_activations_path, params: { account_activation: { email: user.email} }
      #   }.to change(ActionMailer::Base.deliveries, :count).by(1)
      # end
    end

    context 'invalid params' do
      it 'render :new' do
        post account_activations_path, params: { account_activation: { email: 'hogehoge' } }
        expect(response).to render_template :new
      end
    end

    context 'confirmed user' do
      before { log_in_as(user); user.activate; }

      it 'redirect to root' do
        post account_activations_path, params: { account_activation: { email: 'hogehoge' } }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET /confirms/:id/edit' do
    before { user.create_activation_digest }

    context 'valid params' do
      it 'redirect to root' do
        get edit_account_activation_path(user.activation_token), params: { email: user.email }
        expect(response).to redirect_to root_path
      end

      it 'should be user activated' do
        get edit_account_activation_path(user.activation_token), params: { email: user.email }
        expect(user.reload.activated?).to eq true
      end

      it 'should be user logged in' do
        get edit_account_activation_path(user.activation_token), params: { email: user.email }
        expect(is_logged_in?).to eq true
      end
    end

    context 'invalid params' do
      it 'redirect to confirm new' do
        get edit_account_activation_path('hogehoge'), params: { email: user.email }
        expect(response).to redirect_to new_account_activation_path
      end
    end

    context 'confirmed user' do
      before { log_in_as(user); user.activate; }

      it 'redirect to root' do
        get edit_account_activation_path(user.activation_token), params: { email: user.email }
        expect(response).to redirect_to root_path
      end
    end
  end
end

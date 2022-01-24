require 'rails_helper'

RSpec.describe ProfilesController, type: :request do
  let(:user) { create(:user) }
  let(:valid_params) { attributes_for(:profile) }
  let(:invalid_params) { attributes_for(:profile, name: 'a' * 1000) }

  describe "GET /settings/profile" do
    context 'logged in user' do
      before do
        activate_as(user)
        get edit_user_profile_path
      end

      it 'should be success' do
        expect(response).to have_http_status 200
      end
    end

    context 'non logged in user' do
      before do
        activate_as(user)
        log_out_as(user)
        get edit_user_profile_path
      end

      it 'should redirect to login page' do
        expect(response).to redirect_to new_session_path
      end
    end

    context 'non activate user' do
      before do
        log_in_as(user)
        get edit_user_profile_path
      end

      it 'should redirect activation form' do
        expect(response).to redirect_to new_account_activation_path
      end
    end
  end

  describe "PATCH /users/:user_name/profiles/:id" do
    context 'valid params' do
      before do
        activate_as(user)
        patch user_profile_path(user, user.profile), params: { profile: valid_params }
      end

      it 'should redirect to profile edit page' do
        expect(response).to redirect_to edit_user_profile_path
      end
    end

    context 'invalid params' do
      before do
        activate_as(user)
        patch user_profile_path(user, user.profile), params: { profile: invalid_params }
      end

      it 'render :edit' do
        expect(response).to render_template :edit
      end
    end

    context 'non logged in user' do
      before do
        activate_as(user)
        log_out_as(user)
        patch user_profile_path(user, user.profile), params: { profile: valid_params }
      end

      it 'should redirect to login page' do
        expect(response).to redirect_to new_session_path
      end
    end

    context 'non activate user' do
      before do
        log_in_as(user)
        patch user_profile_path(user, user.profile), params: { profile: valid_params }
      end

      it 'should redirect activation form' do
        expect(response).to redirect_to new_account_activation_path
      end
    end
  end
end

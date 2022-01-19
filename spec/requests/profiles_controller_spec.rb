require 'rails_helper'

RSpec.describe ProfilesController, type: :request do
  let(:user) { create(:user) }
  let(:valid_params) { attributes_for(:profile) }
  let(:invalid_params) { attributes_for(:profile, name: 'a' * 1000) }

  describe "GET /settings/profile" do
    context 'logged in user' do
      it 'should be success' do
        log_in_as(user)
        get edit_user_profile_path
        expect(response).to have_http_status 200
      end
    end

    context 'non logged in user' do
      it 'should redirect to login page' do
        get edit_user_profile_path
        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe "PATCH /users/:user_name/profiles/:id" do
    context 'valid params' do
      before { log_in_as(user) }

      it 'should redirect to profile edit page' do
        patch user_profile_path(user, user.profile), params: { profile: valid_params }
        expect(response).to redirect_to edit_user_profile_path
      end

      it 'should update profile' do
        patch user_profile_path(user, user.profile), params: { profile: valid_params }
        expect(user.reload.profile.name).to eq valid_params[:name]
      end
    end

    context 'invalid params' do
      it 'render :edit' do
        log_in_as(user)
        patch user_profile_path(user, user.profile), params: { profile: invalid_params }
        expect(response).to render_template :edit
      end
    end

    context 'non logged in user' do
      it 'should redirect to login page' do
        patch user_profile_path(user, user.profile), params: { profile: valid_params }
        expect(response).to redirect_to new_session_path
      end
    end
  end
end

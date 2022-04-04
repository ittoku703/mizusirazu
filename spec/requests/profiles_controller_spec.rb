require 'rails_helper'

RSpec.describe ProfilesController, type: :request do
  describe "GET /settings/profile" do
    let!(:user) { create(:user) }

    context 'logged in user' do
      before do
        log_in_as(user)
        get edit_user_profile_path
      end

      it { it_should_be_success() }
    end

    context 'non logged in user' do
      before do
        get edit_user_profile_path
      end

      it { it_redirect_to(new_session_path()) }
    end
  end

  describe "PATCH /users/:user_name/profiles/:id" do
    let!(:user) { create(:user) }
    let!(:valid_params) { attributes_for(:profile, avatar: fixture_file_upload('test.png')) }
    let!(:invalid_params) { attributes_for(:profile, name: 'a' * 1000) }

    context 'valid params' do
      before do
        log_in_as(user)
        patch user_profile_path(user, user.profile), params: { profile: valid_params }
      end

      it { it_redirect_to(edit_user_profile_path()) }

      it 'avatar attached is true' do
        expect(user.profile.reload.avatar.attached?).to eq true
      end

    end

    context 'invalid params' do
      before do
        log_in_as(user)
        patch user_profile_path(user, user.profile), params: { profile: invalid_params }
      end

      it { it_render(:edit) }
    end

    context 'non logged in user' do
      before do
        activate_as(user)
        patch user_profile_path(user, user.profile), params: { profile: valid_params }
      end

      it { it_redirect_to(new_session_path()) }
    end
  end
end

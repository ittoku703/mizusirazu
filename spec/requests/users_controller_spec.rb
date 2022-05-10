require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "GET /users" do
    before do
      get users_path()
    end

    it { it_should_be_success() }
  end

  describe 'GET /signup' do
    let!(:user) { create(:user) }

    context 'non logged in user' do
      before do
        get new_user_path()
      end

      it { it_should_be_success() }
    end

    context 'logged in user' do
      before do
        log_in_as(user)
        get new_user_path()
      end

      it { it_redirect_to(root_path()) }
    end
  end

  describe 'POST /users' do
    let!(:valid_params) { attributes_for(:user, password_confirmation: 'password') }
    let!(:invalid_params) { attributes_for(:user, password_confirmation: 'bar') }

    context 'valid params' do
      before do
        post users_path(), params: { user: valid_params }
      end

      it { it_redirect_to(root_path()) }
      it { it_create_object(User) }
      it { it_send_email() }
    end

    context 'invalid params' do
      before do
        post users_path(), params: { user: invalid_params }
      end

      it { it_status_code_is(422) }
      it { it_render(:new) }
    end

    context 'logged in user' do
      let!(:user) { create(:user) }

      before do
        log_in_as(user)
        post users_path(), params: { user: valid_params }
      end

      it { it_redirect_to(root_path()) }
    end

    context 'reCAPTCHA' do
      before do
        allow_recaptcha()
        post users_path(), params: { user: valid_params }
      end

      it { it_render(:new) }
    end
  end

  describe 'GET /users/:name' do
    let!(:user) { create(:user) }

    before do
      get user_path(user)
    end

    it { it_should_be_success() }
  end

  describe 'GET /settings/user' do
    let!(:user) { create(:user) }

    context 'logged in user' do
      before do
        log_in_as(user)
        get edit_user_path()
      end

      it { expect(response).to have_http_status 200 }
    end

    context 'non logged in user' do
      before do
        get edit_user_path()
      end

      it { it_redirect_to(new_session_path()) }
    end
  end

  describe 'PATCH /users/:name' do
    let!(:user) { create(:user) }
    let!(:valid_params) { attributes_for(:user, email: user.email, password_confirmation: 'password') }
    let!(:invalid_params) { attributes_for(:user, password_confirmation: 'bar') }

    context 'valid params' do
      before do
        log_in_as(user)
        patch user_path(user), params: { user: valid_params }
      end

      it { it_redirect_to(edit_user_path()) }
    end

    context 'invalid params' do
      before do
        log_in_as(user)
        patch user_path(user), params: { user: invalid_params }
      end

      it { it_render(:edit) }
    end

    context 'non logged in user' do
      before do
        patch user_path(user), params: { user: valid_params }
      end

      it { it_redirect_to(new_session_path()) }
    end

    context 'email changed' do
      before do
        valid_params[:email] = 'email@changed.com'
        ActionMailer::Base.deliveries.clear
        log_in_as(user)
        patch user_path(user), params: { user: valid_params }
      end

      it { it_send_email() }
      it { it_redirect_to(root_path()) }
    end
  end

  describe 'DELETE /users/:name' do
    let!(:user) { create(:user) }

    context 'logged in user' do
      before do
        log_in_as(user)
        delete user_path(user)
      end

      it { it_delete_object(User) }
      it { it_redirect_to(root_path()) }
    end

    context 'non logged in user' do
      before do
        delete user_path(user)
      end

      it { it_redirect_to(new_session_path()) }
    end
  end

  describe 'GET /users/:user_name/microposts' do
    let!(:user) { create(:user) }

    before do
      get user_microposts_path(user)
    end

    it { it_should_be_success() }
  end

  describe 'GET /users/:user_name/followers' do
    let!(:user) { create(:user) }

    before do
      get user_followers_path(user)
    end

    it { it_should_be_success() }
  end
  
  describe 'GET /users/:user_name/following' do
    let!(:user) { create(:user) }

    before do
      get user_following_path(user)
    end

    it { it_should_be_success() }
  end
end

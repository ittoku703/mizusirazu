require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:user) { create(:user) }
  let(:valid_params) { attributes_for(:user, password_confirmation: 'password') }
  let(:invalid_params) { attributes_for(:user, password_confirmation: 'bar') }

  describe "GET /users" do
    context 'all users' do
      it 'should be success' do
        get users_path
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'GET /signup' do
    context 'logged in user' do
      before { log_in_as(user) }

      it 'redirect to root' do
        get new_user_path
        expect(response).to redirect_to root_path
      end
    end

    context 'non logged in user' do
      it 'should be success' do
        get new_user_path
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'POST /users' do
    context 'valid params' do
      it 'redirect to user page' do
        post users_path, params: { user: valid_params }
        expect(response).to have_http_status 302
      end

      it 'user count +1' do
        expect {
          post users_path, params: { user: valid_params }
        }.to change(User, :count).by(1)
      end
    end

    context 'invalid params' do
      it 'status is 422' do
        post users_path, params: { user: invalid_params }
        expect(response).to have_http_status 422
      end

      it 'render :new' do
        post users_path, params: { user: invalid_params }
        expect(response).to render_template :new
      end
    end

    context 'logged in user' do
      it 'redirect to root' do
        log_in_as(user)
        post users_path, params: { user: valid_params }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET /users/:name' do
    context 'all users' do
      it 'should be success' do
        get user_path(user)
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'GET /settings/user' do
    context 'logged in user' do
      before { log_in_as(user) }

      it 'should be success' do
        get edit_user_path()
        expect(response).to have_http_status 200
      end
    end

    context 'non logged in user' do
      it 'should redirect user page' do
        get edit_user_path()
        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe 'PATCH /users/:name' do
    context 'valid params' do
      before do
        log_in_as(user)
        valid_params[:name] = 'update_user'
        patch user_path(user), params: { user: valid_params }
      end

      it 'should redirect to user page' do
        expect(response).to redirect_to user.reload
      end

      it 'should update user' do
        expect(user.reload.name).to eq valid_params[:name]
      end
    end

    context 'invalid params' do
      before do
        log_in_as(user)
        patch user_path(user), params: { user: invalid_params }
      end

      it 'render :edit' do
        expect(response).to render_template :edit
      end
    end

    context 'non logged in user' do
      it 'redirect to login page' do
        patch user_path(user), params: { user: valid_params }
        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe 'DELETE /users/:name' do
    context 'logged in user' do
      before { log_in_as(user) }

      it 'should delete user' do
        expect { delete user_path(user) }.to change(User, :count).by(-1)
      end
    end

    context 'non logged in user' do
      it 'should redirect to root' do
        delete user_path(user)
        expect(response).to redirect_to new_session_path
      end
    end
  end
end

require 'rails_helper'

RSpec.describe MicropostsController, type: :request do
  let(:user) { create(:user) }
  let(:other) { create(:other) }
  let(:micropost) { user.microposts.create(attributes_for(:micropost)) }

  describe 'GET /microposts' do
    it 'is OK' do
      get microposts_path
      expect(response.status).to eq 200
    end
  end

  describe 'GET /microposts/new' do
    context 'when logged in user' do
      it 'is OK' do
        login_user
        get new_micropost_path
        expect(response.status).to eq 200
      end
    end

    context 'when non logged in user' do
      it 'redirect to login page' do
        get new_micropost_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST /microposts' do
    context 'when valid params' do
      before { login_user }

      it 'redirect to micropost page' do
        post microposts_path, params: { micropost: { title: 'Title', content: 'Content' } }
        expect(response).to redirect_to micropost_path(user.microposts[0])
      end

      it 'one more micropost' do
        post microposts_path, params: { micropost: { title: 'Title', content: 'Content' } }
        expect(Micropost.count).to eq 1
      end

      it 'images is attached' do
        post microposts_path, params: {
          micropost: {
            title: 'Title',
            content: 'Content',
            images: [fixture_file_upload('spec/factories/images/test.gif')]
          }
        }
        expect(ActiveStorage::Attachment.count).to eq 1
      end
    end

    context 'when invalid params' do
      it 'is rollback' do
        login_user
        post microposts_path, params: { micropost: { title: '', content: '' } }
        expect(response).to render_template :new
      end
    end

    context 'when non logged in user' do
      it 'redirect to login page' do
        post microposts_path, params: { micropost: { title: 'Title', content: 'Content' } }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET /microposts/:id' do
    it 'is OK' do
      get micropost_path(micropost)
      expect(response.status).to eq 200
    end
  end

  describe 'GET /microposts/:id/edit' do
    context 'when logged in user' do
      it 'is OK' do
        login_user
        get edit_micropost_path(micropost)
        expect(response.status).to eq 200
      end
    end

    context 'when non logged in user' do
      it 'redirect to login page' do
        get edit_micropost_path(micropost)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH /microposts/:id' do
    context 'when valid params' do
      it 'redirect to micropost page' do
        login_user
        patch micropost_path(micropost), params: { micropost: { title: 'new title', content: 'new content' } }
        expect(response).to redirect_to micropost_path(micropost)
      end

      it 'images is attached' do
        login_user
        patch micropost_path(micropost), params: {
          micropost: {
            title: 'Title',
            content: 'Content',
            images: [fixture_file_upload('spec/factories/images/test.gif')]
          }
        }
        expect(ActiveStorage::Attachment.count).to eq 1
      end
    end

    context 'when invalid params' do
      it 'is rollback' do
        login_user
        patch micropost_path(micropost), params: { micropost: { title: '', content: '' } }
        expect(response).to render_template :edit
      end
    end

    context 'when non logged in user' do
      it 'is redirect to login page' do
        patch micropost_path(micropost), params: { micropost: { title: 'new title', content: 'new content' } }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE /microposts/:id' do
    context 'when valid params' do
      it 'redirect to user microposts page' do
        login_user
        delete micropost_path(micropost)
        expect(response).to redirect_to user_microposts_path
      end
    end

    context 'when invalid params' do
      it 'is not found' do
        login_user
        delete micropost_path('hoge')
        expect(response.status).to eq 404
      end
    end

    context 'when non logged in user' do
      it 'redirect to login page' do
        delete micropost_path(micropost)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET /users/:id/microposts' do
    it 'is OK' do
      get user_microposts_path(user)
      expect(response.status).to eq 200
    end
  end
end

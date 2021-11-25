require 'rails_helper'

RSpec.describe MicropostsController, type: :request do
  let(:user) { create(:user) }
  let(:other) { create(:other) }
  let(:micropost) { create(:micropost, user: user) }

  describe 'GET /microposts' do
    it 'is OK' do
      get microposts_path
      expect(response.status).to eq 200
    end
  end

  describe 'GET /microposts/new' do
    subject(:valid_params) do
      get new_micropost_path
    end

    context 'when logged in user' do
      before { login_user }

      it 'is OK' do
        expect(valid_params).to eq 200
      end
    end

    context 'when non logged in user' do
      it 'redirect to login page' do
        expect(valid_params).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST /microposts' do
    subject(:valid_params) do
      post microposts_path, params: {
        micropost: {
          title: 'Title',
          content: 'Content',
          images: [fixture_file_upload('spec/factories/images/test.gif')]
        }
      }
    end

    subject(:invalid_params) do
      post microposts_path, params: {
        micropost: {
          title: '',
          content: ''
        }
      }
    end

    context 'when valid params' do
      before { login_user }

      it 'redirect to micropost page' do
        expect(valid_params).to redirect_to user.microposts.last
      end

      it 'one more micropost' do
        expect { valid_params }.to change(Micropost, :count).by(1)
      end

      it 'images is attached' do
        expect { valid_params }.to change(ActiveStorage::Attachment, :count).by(1)
      end
    end

    context 'when invalid params' do
      before { login_user }

      it 'is rollback' do
        expect(invalid_params).to render_template :new
      end
    end

    context 'when non logged in user' do
      it 'redirect to login page' do
        expect(valid_params).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET /microposts/:id' do
    subject(:valid_params) { get micropost_path(micropost) }

    it 'is OK' do
      expect(valid_params).to eq 200
    end
  end

  describe 'GET /microposts/:id/edit' do
    subject(:valid_params) { get edit_micropost_path(micropost) }

    context 'when logged in user' do
      before { login_user }

      it 'is OK' do
        expect(valid_params).to eq 200
      end
    end

    context 'when non logged in user' do
      it 'redirect to login page' do
        expect(valid_params).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH /microposts/:id' do
    subject(:valid_params) do
      patch micropost_path(micropost), params: {
        micropost: {
          title: 'new title',
          content: 'new content',
          images: [fixture_file_upload('spec/factories/images/test.gif')]
        }
      }
    end

    subject(:invalid_params) do
      patch micropost_path(micropost), params: {
        micropost: {
          title: '',
          content: ''
        }
      }
    end

    context 'when valid params' do
      before { login_user }

      it 'redirect to micropost page' do
        expect(valid_params).to redirect_to micropost_path(micropost)
      end

      it 'images is attached' do
        expect { valid_params }.to change(ActiveStorage::Attachment, :count).by(1)
      end
    end

    context 'when invalid params' do
      before { login_user }

      it 'is rollback' do
        expect(invalid_params).to render_template :edit
      end
    end

    context 'when non logged in user' do
      it 'is redirect to login page' do
        expect(valid_params).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE /microposts/:id' do
    subject(:valid_params) { delete micropost_path(micropost) }

    subject(:invalid_params) { delete micropost_path('hoge') }

    context 'when valid params' do
      before { login_user }

      it 'redirect to user microposts page' do
        expect(valid_params).to redirect_to user_microposts_path
      end
    end

    context 'when invalid params' do
      before { login_user }

      it 'is not found' do
        expect(invalid_params).to eq 404
      end
    end

    context 'when non logged in user' do
      it 'redirect to login page' do
        expect(valid_params).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET /users/:id/microposts' do
    subject(:valid_params) { get user_microposts_path(user) }

    it 'is OK' do
      expect(valid_params).to eq 200
    end
  end
end

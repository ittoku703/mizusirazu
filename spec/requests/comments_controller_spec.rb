require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost) }
  let(:comment) { create(:comment, micropost: micropost, user: user) }

  describe 'POST /microposts/:micropost_id/comments' do
    subject(:valid_params) {
      post micropost_comments_path(micropost), params: {
        comment: {
          micropost_id: micropost.id,
          content: 'content'
        }
      }
    }

    subject(:image_attach) {
      post micropost_comments_path(micropost), params: {
        comment: {
          micropost_id: micropost.id,
          content: 'content',
          images: [fixture_file_upload('spec/factories/images/test.gif')]
        }
      }
    }

    context 'when logged in user' do
      before { login_user }

      it 'redirect to micropost path' do
       expect(valid_params).to redirect_to micropost
      end

      it 'comment count +1' do
        expect{ valid_params }.to change(Comment, :count).by(1)
      end

      it 'images is attached' do
        expect{ image_attach }.to change(ActiveStorage::Attachment, :count).by(1)
      end
    end

    context 'when non logged in user' do
      it 'redirect to login page' do
        expect(valid_params).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH /micropost/:micropost_id/comment/:id' do
    subject(:valid_params) {
      patch micropost_comment_path(micropost, comment), params: {
        comment: {
          micropost_id: micropost.id,
          content: 'content'
        }
      }
    }

    subject(:image_attach) {
      patch micropost_comment_path(micropost, comment), params: {
        comment: {
          micropost_id: micropost.id,
          content: 'content',
          images: [fixture_file_upload('spec/factories/images/test.png')]
        }
      }
    }

    it 'redirect to micropost page' do
      login_user
      expect(valid_params).to redirect_to micropost
    end

    it 'images is attached' do
      login_user
      expect{ image_attach }.to change(ActiveStorage::Attachment, :count).by(1)
    end
  end

  describe 'DELETE /microposts/:micropost_id/comment/:id' do
    subject(:valid_params) {
      delete micropost_comment_path(micropost, comment)
    }

    it 'redirect to micropost page' do
      login_user
      expect(valid_params).to redirect_to micropost
    end

    it 'comment count -1' do
      login_user
      comment.save
      expect { valid_params }.to change(Comment, :count).by(-1)
    end
  end
end

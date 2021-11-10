require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  let(:user) { create(:user) }
  let(:comment) { create(:comment) }

  describe 'POST /comments' do
    context 'when logged in user' do
      it 'redirect to micropost path' do
        login_user
        puts comment.micropost
        post comments_path, params: {
          comment: {
            micropost_id: comment.micropost.id,
            content: 'content'
          }
        }
        expect(response).to redirect_to comment.micropost
      end

      it 'comment count +1' do
        login_user
        post comments_path, params: {
          comment: {
            micropost_id: comment.micropost.id,
            content: 'content'
          }
        }
        expect(Micropost.count).to eq 1
      end
    end

    context 'when non logged in user' do
      it 'redirect to login page' do
        post comments_path, params: {
          comment: {
            micropost_id: comment.micropost.id,
            content: 'content'
          }
        }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH /comment/:id' do
    it 'redirect to micropost page' do
      login_user
      patch comment_path(comment), params: {
        comment: {
          micropost_id: comment.micropost.id,
          content: 'newcontent'
        }
      }
      expect(response).to redirect_to comment.micropost
    end
  end

  describe 'DELETE /comment/:id' do
    it 'redirect to micropost page' do
      login_user
      delete comment_path(comment)
      expect(response).to redirect_to comment.micropost
    end

    it 'comment count -1' do
      login_user
      comment.save
      expect { delete comment_path(comment) }.to change(Comment, :count).by(-1)
    end
  end
end

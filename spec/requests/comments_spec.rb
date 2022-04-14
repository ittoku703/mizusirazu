require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  describe 'POST /microposts/:micropost_id/comments' do
    let!(:micropost)      { create(:micropost) }
    let!(:user)           { micropost.user }
    let!(:valid_params)   { attributes_for(:comment, micropost_id: micropost.id) }
    let!(:invalid_params) { attributes_for(:comment, content: ' ') }

    context 'valid params' do
      before do
        log_in_as(user)
        post micropost_comments_path(micropost), params: { comment: valid_params }
      end

      it { it_create_object(Comment) }
      it { it_redirect_to(micropost_path(micropost)) }
    end

    context 'invalid params' do
      before do
        log_in_as(user)
        post micropost_comments_path(micropost), params: { comment: invalid_params }
      end

      it { it_redirect_to(micropost_path(micropost)) }
    end

    context 'non logged in user' do
      before do
        post micropost_comments_path(micropost), params: { comment: valid_params }
      end

      it { it_redirect_to(new_session_path()) }
    end
  end

  describe 'PATCH /microposts/:micropost_id/comments/:id' do
    let!(:micropost)      { create(:micropost) }
    let!(:user)           { micropost.user }
    let!(:comment)        { user.comments.create!(content: 'create comment', micropost_id: micropost.id) }
    let!(:valid_params)   { attributes_for(:comment, content: 'update comment') }
    let!(:invalid_params) { attributes_for(:comment, content: ' ') }

    context 'valid params' do
      before do
        log_in_as(user)
        patch micropost_comment_path(micropost, comment), params: {  comment: valid_params }
      end

      it { expect(comment.reload.content).to eq 'update comment' }
      it { it_redirect_to(micropost_path(micropost)) }
    end

    context 'invalid params' do
      before do
        log_in_as(user)
        patch micropost_comment_path(micropost, comment), params: {  comment: invalid_params }
      end

      it { expect(comment.reload.content).not_to eq ' ' }
      it { it_redirect_to(micropost_path(micropost)) }
    end

    context 'non logged in user' do
      before do
        patch micropost_comment_path(micropost, comment), params: {  comment: valid_params }
      end

      it { it_redirect_to(new_session_path()) }
    end
  end

  describe 'DELETE /microposts/:micropost_id/comments/:id' do
    let!(:micropost) { create(:micropost) }
    let!(:user)      { micropost.user }
    let!(:comment)   { user.comments.create!(content: 'create comment', micropost_id: micropost.id) }

    context 'valid params' do
      before do
        log_in_as(user)
        delete micropost_comment_path(micropost, comment)
      end

      it { it_delete_object(Comment) }
      it { it_redirect_to(micropost_path(micropost)) }
    end

    context 'non logged in user' do
      before do
        delete micropost_comment_path(micropost, comment)
      end

      it { it_redirect_to(new_session_path()) }
    end
  end
end

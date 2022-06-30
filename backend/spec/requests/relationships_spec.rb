require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  describe 'POST /relationships' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:other_user) }
    let!(:valid_params) { { followed_id: other_user.id } }
    let!(:invalid_params) { { followed_id: 0x123456789 } }
    
    context 'valid params' do
      before do
        log_in_as(user)
        post relationships_path(), params: { relationship: valid_params }
      end

      it { it_create_object(Relationship) }
      it { it_redirect_to(user_path(other_user)) }
    end

    context 'invalid params' do
      before do
        log_in_as(user)
        post relationships_path(), params: { relationship: invalid_params }
      end

      it { it_status_code_is(302) }
      it { it_redirect_to(user_path(user)) }
    end

    context 'non logged in user' do
      before do
        post relationships_path(), params: { relationship: valid_params }
      end

      it { it_redirect_to(new_session_path()) }
    end
  end

  describe 'DELETE /relationships/:id' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:other_user) }
    let!(:relationship) { Relationship.create(follower_id: user.id, followed_id: other_user.id) }

    context 'valid params' do
      before do
        log_in_as(user)
        delete relationship_path(relationship)
      end

      it { it_delete_object(Relationship) }
      it { it_redirect_to(user_path(other_user)) }
    end

    context 'non logged in user' do
      before do
        delete relationship_path(relationship)
      end

      it { it_redirect_to(new_session_path()) }
    end

    context 'non correct user' do
      before do
        log_in_as(other_user)
        delete relationship_path(relationship)
      end

      it { it_status_code_is(302) }
      it { it_redirect_to(root_path()) }
    end
  end
end

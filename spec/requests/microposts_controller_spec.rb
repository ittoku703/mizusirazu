require 'rails_helper'

RSpec.describe MicropostsController, type: :request do
  describe 'GET /microposts' do
    before do
      get microposts_path()
    end

    it { it_should_be_success() }
  end

  describe 'GET /microposts/new' do
    let!(:user) { create(:user) }

    context 'logged in user' do
      before do
        log_in_as(user)
        get new_micropost_path()
      end

      it { it_should_be_success() }
    end

    context 'non logged in user' do
      before do
        activate_as(user)
        get new_micropost_path()
      end

      it { it_redirect_to(new_session_path()) }
    end
  end

  describe 'POST /microposts' do
    let!(:user) { create(:user) }
    let!(:valid_params) { attributes_for(:micropost, images: fixture_file_upload('test.png')) }
    let!(:invalid_params) { attributes_for(:micropost, content: '') }

    context 'valid params' do
      before do
        log_in_as(user)
        post microposts_path, params: { micropost: valid_params }
      end

      it { it_redirect_to(micropost_path(Micropost.last)) }

      it { expect(Micropost.count).to eq 1 }
      it { expect(Micropost.last.images.attached?).to eq true }
    end

    context 'invalid params' do
      before do
        log_in_as(user)
        post microposts_path, params: { micropost: invalid_params }
      end

      it { it_render(:new) }
    end

    context 'non logged in user' do
      before do
        post microposts_path, params: { micropost: valid_params }
      end

      it { it_redirect_to(new_session_path()) }
    end
  end

  describe 'GET /show' do
    let!(:micropost) { create(:micropost) }

    before do
      get micropost_path(micropost)
    end

    it { it_should_be_success() }
  end

  describe 'GET /microposts/:id/edit' do
    let!(:micropost) { create(:micropost) }
    let!(:other_user) { create(:other_user) }

    context 'correct user' do
      before do
        log_in_as(micropost.user)
        get edit_micropost_path(micropost)
      end

      it { it_should_be_success() }
    end

    context 'non logged in user' do
      before do
        get edit_micropost_path(micropost)
      end

      it { it_redirect_to(new_session_path()) }
    end

    context 'other user' do
      before do
        log_in_as(other_user)
        get edit_micropost_path(micropost)
      end

      it { it_redirect_to(root_path()) }
    end
  end

  describe 'PATCH /microposts/:id' do
    let!(:micropost) { create(:micropost) }
    let!(:other_user) { create(:other_user) }
    let!(:valid_params) { attributes_for(:micropost, images: fixture_file_upload('test.png')) }
    let!(:invalid_params) { attributes_for(:micropost, content: '') }

    context 'valid params' do
      before do
        log_in_as(micropost.user)
        patch micropost_path(micropost), params: { micropost: valid_params }
      end

      it { it_redirect_to(micropost_path(micropost)) }
      it { expect(micropost.images.attached?).to eq true}
    end

    context 'invalid params' do
      before do
        log_in_as(micropost.user)
        patch micropost_path(micropost), params: { micropost: invalid_params }
      end

      it { it_render(:edit) }
    end

    context 'non logged in user' do
      before do
        patch micropost_path(micropost), params: { micropost: valid_params }
      end

      it { it_redirect_to(new_session_path()) }
    end

    context 'other user' do
      before do
        log_in_as(other_user)
        patch micropost_path(micropost), params: { micropost: valid_params }
      end

      it { redirect_to(root_path()) }
    end
  end

  describe 'DELETE microposts/:id' do
    let!(:micropost) { create(:micropost) }
    let!(:other_user) { create(:other_user) }

    context 'correct user' do
      before do
        log_in_as(micropost.user)
        delete micropost_path(micropost)
      end

      it { it_redirect_to(root_path()) }

      it { expect(Micropost.count).to eq 0 }
    end

    context 'other user' do
      before do
        log_in_as(other_user)
        delete micropost_path(micropost)
      end

      it { it_redirect_to(root_path()) }

      it { expect(Micropost.count).to eq 1 }
    end
  end
end

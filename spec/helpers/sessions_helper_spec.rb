require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:user) { create(:user) }
  let(:log_in_as_user) { log_in_as(helper, user) }

  describe 'logged_in?' do
    context 'logged in user' do
      before { log_in_as_user }
      it 'return true' do
        expect(helper.logged_in?).to eq true
      end
    end

    context 'non logged in user' do
      it 'return false' do
        expect(helper.logged_in?).to eq false
      end
    end
  end

  describe 'log_in(user)' do
    it 'logged in' do
      expect { log_in_as_user }.to(
        change { helper.logged_in? }.from(false).to(true)
      )
    end
  end

  describe 'remember(user)' do
    it 'make the user\'s session permanent' do
      expect { helper.send(:remember, user) }.to(
        change { user.remember_digest.is_a?(String) }.from(false).to(true) &&
        change { cookies.permanent.signed[:user_id] }.from(nil).to(user.id) &&
        change { cookies.permanent[:remember_token].is_a?(String) }.from(false).to(true)
      )
    end
  end

  describe 'current_user' do
    context 'logged in user' do
      before { log_in_as_user }
      it 'return current' do
        expect(helper.send(:current_user)).to eq user
      end
    end

    context 'non logged in user' do
      it 'return nil' do
        expect(helper.send(:current_user)).not_to eq user
      end
    end
  end

  describe 'current_user?(user)' do
    context 'logged in user' do
      before { log_in_as_user }
      it 'return true' do
        expect(helper.send(:current_user?, user)).to eq true
      end
    end

    context 'not logged in user' do
      it 'return false' do
        expect(helper.send(:current_user?, user)).to eq false
      end
    end
  end

  # passing test
  # describe 'correct_user(name)' do
  # end

  # passing test
  # describe 'already_logged_in' do
  # end

  describe 'forget(user)' do
    before { helper.send(:remember, user) }
    it 'destroy permanent session' do
      expect { helper.send(:forget, user) }.to(
        change { user.remember_digest.is_a?(String) }.from(true).to(false) &&
        change { cookies.permanent.signed[:user_id] }.from(user.id).to(nil) &&
        change { cookies.permanent[:remember_token] }.from(user.remember_token).to(nil)
      )
    end
  end

  describe 'log_out' do
    before { log_in_as_user }
    it 'should be log out' do
      expect { helper.send(:log_out) }.to(
        change { helper.logged_in? }.from(true).to(false)
      )
    end
  end

  # passing test
  # describe 'redirect_back_or(default, options = {})' do
  # end

  # passing test
  # describe 'store_location' do
  # end
end

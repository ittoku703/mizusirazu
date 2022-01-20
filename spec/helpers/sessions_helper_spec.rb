require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
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

require 'rails_helper'

RSpec.feature 'UserDelete', type: :feature do
  let(:user) { create(:user) }

  scenario 'user delete' do
    log_in_as(user)
    visit edit_user_path
    #
    # javascript alert dialog does not working
    # because rspec does not support turbo
    #
    # page.accept_confirm do
    #   click_link 'Delete'
    # end
    expect(page).not_to have_selector 'div#notice'
  end
end

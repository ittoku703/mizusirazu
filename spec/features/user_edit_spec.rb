require 'rails_helper'

RSpec.feature 'UserEdit', type: :feature do
  let(:user) { create(:user) }

  scenario 'valid user settings' do
    log_in_as(user)
    user.activate # <- for now
    visit edit_user_path
    fill_in 'Name', with: 'update_user'
    fill_in 'Email', with: user.email
    click_button 'Update user'
    expect(page).to have_selector 'div#notice'
    expect(page).to have_content 'update_user'
  end

  scenario 'invalid user settings' do
    log_in_as(user)
    user.activate # <-for now
    visit edit_user_path
    fill_in 'Name', with: 'hoge'
    fill_in 'Email', with: 'bar'
    click_button 'Update user'
    expect(page).to have_selector 'div#error_explanation'
  end

  scenario 'non logged in user settings' do
    # log_in_as(user)
    user.activate
    visit edit_user_path
    expect(page).to have_selector 'div#alert'
  end

  scenario 'non activate user settings' do
    log_in_as(user)
    # user.activate
    visit edit_user_path
    expect(page).to have_selector 'div#alert'
  end
end

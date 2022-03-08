require 'rails_helper'

RSpec.feature 'UserEdit', type: :feature do
  let(:user) { create(:user) }

  scenario 'valid user settings' do
    activate_as(user)
    visit edit_user_path()
    fill_in 'Name', with: 'update_user'
    fill_in 'Email', with: user.email
    click_button 'Update user'
    expect(page).to have_selector 'div#notice'
    expect(page).to have_content 'update_user'
  end

  scenario 'invalid user settings' do
    activate_as(user)
    visit edit_user_path()
    fill_in 'Name', with: 'hoge'
    fill_in 'Email', with: 'bar'
    click_button 'Update user'
    expect(page).to have_selector 'div#error_explanation'
  end

  scenario 'non logged in user settings' do
    visit edit_user_path()
    expect(page).to have_selector 'div#alert'
  end

  scenario 'user email changed' do
    activate_as(user)
    visit edit_user_path()
    fill_in 'Name', with: 'update_user'
    fill_in 'Email', with: 'email@changed.com'
    click_button 'Update user'
    expect(page).to have_selector 'div#notice'
    visit activation_email_link()
    expect(page).to have_selector 'div#notice'
  end
end

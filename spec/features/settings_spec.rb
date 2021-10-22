require 'rails_helper'

RSpec.feature 'Settings', type: :feature do
  let(:user) { create(:user) }

  background do
    logged_in_user
    visit edit_user_path
  end

  scenario 'settings' do
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_on 'Update User'
    expect(page).to have_selector '#notice', text: 'Successfully updated'
  end

  scenario 'settings failed' do
    fill_in 'user[email]', with: 'hogehoge'
    fill_in 'user[password]', with: 'bar'
    fill_in 'user[password_confirmation]', with: 'baz'
    click_on 'Update User'
    expect(page).to have_selector '#error_explanation'
  end
end

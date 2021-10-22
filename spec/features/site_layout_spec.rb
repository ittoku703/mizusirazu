require 'rails_helper'

RSpec.feature 'SiteLayouts', type: :feature do
  let(:user) { create(:user) }

  scenario 'root links (non logged in)' do
    visit root_path
    expect(page).to have_link 'New user'
    expect(page).to have_link 'Log in'
    expect(page).to have_link 'Source code'
    expect(page).to have_link 'Contact'
    expect(page).to have_link 'NES.css'
    expect(page).to have_link 'Nu-きなこもち(font)'
  end

  scenario 'root links (logged in)' do
    logged_in_user
    visit root_path
    expect(page).to have_link 'My page'
    expect(page).to have_link 'Edit profile'
    expect(page).to have_link 'Log out'
  end

  scenario '/user/:id links' do
    visit user_path(user)
    expect(page).to have_link 'Edit user'
    expect(page).to have_link 'Delete user'
  end

  scenario '/signup links' do
    visit new_user_path
    expect(page).to have_link 'Log in'
  end

  scenario '/users/:id/edit links' do
    logged_in_user
    visit edit_user_path
    expect(page).to have_link 'My page'
    expect(page).to have_link 'Delete user'
  end

  scenario '/login links' do
    visit new_user_session_path
    expect(page).to have_link 'New user'
    expect(page).to have_link 'Forget password?'
  end

  scenario 'password/new links' do
    visit new_password_reset_path
    expect(page).to have_link 'New user'
    expect(page).to have_link 'Log in'
  end
end

require 'rails_helper'

RSpec.feature 'SiteLinks', type: :feature do
  let(:user) { create(:user) }

  scenario 'home links' do
    visit root_path
    expect(page).to have_link t('signup')
    expect(page).to have_link t('login')
    expect(page).to have_link t('source_code')
    expect(page).to have_link t('contact')
    expect(page).to have_link 'NES.css'
    expect(page).to have_link 'Nu きなこもち'
    expect(page).to have_link '美咲フォント'
    expect(page).to have_link t('en')
    expect(page).to have_link t('ja')
  end

  scenario 'home links (login_user)' do
    login_user
    visit root_path
    expect(page).to have_link t('my_page')
    expect(page).to have_link t('edit')
    expect(page).to have_link t('logout')
  end

  scenario 'confirmation/new links' do
    visit new_user_confirmation_path
    expect(page).to have_link t('login_user')
    expect(page).to have_link t('new_user')
    expect(page).to have_link t('forget_password')
    expect(page).to have_link t('unlock_user')
  end

  scenario 'password/new links' do
    visit new_user_password_path
    expect(page).to have_link t('login_user')
    expect(page).to have_link t('new_user')
    expect(page).to have_link t('activate_user')
    expect(page).to have_link t('unlock_user')
  end

  scenario '/password/edit?reset_password_token=abcdef' do
    visit edit_user_password_link
    expect(page).to have_link t('login_user')
    expect(page).to have_link t('new_user')
    expect(page).to have_link t('activate_user')
    expect(page).to have_link t('unlock_user')
  end

  scenario 'signup links' do
    visit user_signup_path
    expect(page).to have_link t('login_user')
    expect(page).to have_link t('activate_user')
    expect(page).to have_link t('unlock_user')
  end

  scenario 'profile page links' do
    visit user_profile_path(user)
    expect(page).to have_content user.email
    expect(page).to have_content l(user.created_at)
    expect(page).to have_content l(user.updated_at)
    expect(page).to have_link t('look_microposts')
  end

  scenario 'settings page links' do
    login_user
    visit user_settings_path
    expect(page).to have_link t('delete')
  end

  scenario 'login page links' do
    visit new_user_session_path
    expect(page).to have_link t('new_user')
    expect(page).to have_link t('forget_password')
    expect(page).to have_link t('activate_user')
    expect(page).to have_link t('unlock_user')
  end

  scenario 'unlock page links' do
    visit new_user_unlock_path
    expect(page).to have_link t('login_user')
    expect(page).to have_link t('new_user')
    expect(page).to have_link t('forget_password')
    expect(page).to have_link t('activate_user')
  end
end

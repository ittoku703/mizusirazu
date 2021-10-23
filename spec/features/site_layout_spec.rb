require 'rails_helper'

RSpec.feature 'SiteLayouts', type: :feature do
  let(:user) { create(:user) }

  scenario 'root links (non logged in)' do
    visit root_path
    expect(page).to have_link t('signup')
    expect(page).to have_link t('login')
    expect(page).to have_link t('source_code')
    expect(page).to have_link t('contact')
    expect(page).to have_link 'NES.css'
    expect(page).to have_link 'Nu-きなこもち(font)'
  end

  scenario 'root links (logged in)' do
    logged_in_user
    visit root_path
    expect(page).to have_link t('my_page')
    expect(page).to have_link t('edit')
    expect(page).to have_link t('logout')
  end

  scenario '/user/:id links' do
    visit user_path(user)
    expect(page).to have_link t('edit_user')
    expect(page).to have_link t('delete_user')
  end

  scenario '/signup links' do
    visit new_user_path
    expect(page).to have_link t('login')
  end

  scenario '/users/:id/edit links' do
    logged_in_user
    visit edit_user_path
    expect(page).to have_link t('my_page')
    expect(page).to have_link t('delete_user')
  end

  scenario '/login links' do
    visit new_user_session_path
    expect(page).to have_link t('signup')
    expect(page).to have_link t('forget_password')
  end

  scenario 'password/new links' do
    visit new_password_reset_path
    expect(page).to have_link t('signup')
    expect(page).to have_link t('login')
  end
end

require 'rails_helper'

RSpec.feature 'session user', type: :feature do
  let(:user) { create(:user) }
  background { visit new_user_session_path }
  scenario 'login -> logout' do
    success_login
    expect(page).to have_content 'ログインしました'
    click_link 'Home'
    click_link 'Log out'
    expect(page).to have_content 'ログアウトしました'
  end

  scenario 'login page element check' do
    expect(page).to have_content 'Log in'
    expect(page).to have_link 'Sign up'
    expect(page).to have_selector 'input#user_email'
    expect(page).to have_selector 'input#user_password'
    expect(page).to have_selector 'input#user_remember_me'
    expect(page).to have_button 'Log in'
    expect(page).to have_link 'Forgot your password?'
    expect(page).to have_link 'Didn\'t receive confirmation instructions?'
    expect(page).to have_link 'Didn\'t receive unlock instructions?'
  end
end

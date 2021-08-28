require 'rails_helper'

RSpec.feature "session user", type: :feature do
  let(:user) { create(:user) }
  background { visit new_user_session_path }
  scenario 'login and logout' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content 'ログインしました'
    visit root_path
    click_link 'Log out'
    expect(page).to have_content 'ログアウトしました'
  end

  scenario 'login page element check' do
    expect(page).to have_content "Log in"
    expect(page).to have_link 'Sign up'
    expect(page).to have_selector 'input#user_email'
    expect(page).to have_selector 'input#user_password'
    expect(page).to have_link 'Forgot your password?'
  end
end

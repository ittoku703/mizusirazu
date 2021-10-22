require 'rails_helper'

RSpec.feature 'Logins', type: :feature do
  let(:user) { create(:user) }

  background do
    user.activate!
    visit new_user_session_path
  end

  scenario 'login and logout' do
    fill_in 'email', with: user.email
    fill_in 'password', with: 'password'
    click_on 'Login'
    expect(page.has_selector?('#notice', text: 'Login successful')).to eq true
    click_link 'Log out'
    expect(page.has_selector?('#notice', text: 'Logged out')).to eq true
  end

  scenario 'login failed' do
    fill_in 'email', with: 'hogehoge'
    fill_in 'password', with: ''
    click_on 'Login'
    expect(page).to have_selector '#alert', text: 'Login failed'
  end
end

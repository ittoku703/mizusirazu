require 'rails_helper'

RSpec.feature "Signups", type: :feature do
  scenario 'signup user' do
    visit new_user_registration_path
    fill_in 'Name',                  with: 'shinzanmono'
    fill_in 'Email',                 with: 'shinzanmono1192@gmail.com'
    fill_in 'Password',              with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content 'Welcome to the mizusirazu.net'
  end

  scenario 'signup user when invalid input' do
    visit new_user_registration_path
    click_button 'Sign up'
    expect(page).to have_content 'prohibited this user from being saved:'
  end

end

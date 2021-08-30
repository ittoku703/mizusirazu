require 'rails_helper'

RSpec.feature "Passwords", type: :feature do
  let(:user) { create(:user) }
  background { ActionMailer::Base.deliveries.clear }
  scenario 'password reset' do
    # send password reset email
    visit new_user_password_path
    fill_in 'Email', with: user.email
    click_button 'Send me reset password instruction'
    expect(page).to have_content 'パスワードの再設定について数分以内にメールでご連絡いたします。'
    # mail check
    mail = ActionMailer::Base.deliveries.last
    url = extract_url(mail)
    # edit password 
    visit url
    expect(page).to have_content 'Change your password'
    fill_in 'New password', with: 'new_password'
    fill_in 'Confirm new password', with: 'new_password'
    click_button 'Change my password'
    expect(page).to have_content 'パスワードが正しく変更されました。'
  end

  scenario 'forget password page elements check' do
    visit new_user_password_path
    expect(page).to have_content 'Forgot your password?'
    expect(page).to have_selector 'input#user_email'
    expect(page).to have_button 'Send me reset password instruction'
    expect(page).to have_link 'Log in'
    expect(page).to have_link 'Sign up'
   end

  scenario 'edit password page element check' do
    # setup
    user.send_reset_password_instructions
    mail = ActionMailer::Base.deliveries.last
    url = extract_url(mail)
    # edit password page !!!
    visit url
    expect(page).to have_content "Change your password"
    expect(page).to have_selector 'input#user_password'
    expect(page).to have_selector 'input#user_password_confirmation'
    expect(page).to have_button 'Change my password'
    expect(page).to have_link 'Log in'
    expect(page).to have_link 'Sign up'
  end
end

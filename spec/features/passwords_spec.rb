require 'rails_helper'

RSpec.feature "Passwords", type: :feature do
  let(:user) { create(:user) }
  scenario 'password reset' do
    # send password reset email
    visit new_user_password_path
    fill_in 'Email', with: user.email
    click_button 'Send me reset password instruction'
    expect(page).to have_content 'パスワードの再設定について数分以内にメールでご連絡いたします。'
    # mail check
    visit_email_link_url
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
    user.send_reset_password_instructions
    visit_email_link_url
    expect(page).to have_content "Change your password"
    expect(page).to have_selector 'input#user_password'
    expect(page).to have_selector 'input#user_password_confirmation'
    expect(page).to have_button 'Change my password'
    expect(page).to have_link 'Log in'
    expect(page).to have_link 'Sign up'
    expect(page).to have_link 'Didn\'t receive confirmation instructions?'
    expect(page).to have_link 'Didn\'t receive unlock instructions?'
  end
end

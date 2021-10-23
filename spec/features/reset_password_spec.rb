require 'rails_helper'

RSpec.feature 'ResetPasswords', type: :feature do
  let(:user) { create(:user) }

  scenario 'reset password' do
    visit new_password_reset_path
    fill_in 'email', with: user.email
    click_button t('reset_password')
    expect(page).to have_selector '#notice', text: 'sent reset password to your email'
    visit email_link
    expect(page).to have_selector '#notice', text: 'Please set password'
    fill_in 'password', with: 'new-password'
    fill_in 'password_confirmation', with: 'new-password'
    click_on t('reset_password')
    expect(page).to have_selector '#notice', text: 'Reset password successfully'
  end

  scenario 'reset password failed (not found email)' do
    visit new_password_reset_path
    fill_in 'email', with: 'hogehoge'
    click_on t('reset_password')
    expect(page).to have_selector '#alert', text: 'Not found email'
  end
end

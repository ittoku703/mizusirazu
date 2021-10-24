require 'rails_helper'

RSpec.feature 'ResetPasswords', type: :feature do
  let(:user) { create(:user) }

  scenario 'reset password' do
    visit new_password_reset_path
    fill_in 'email', with: user.email
    click_button t('reset_password')
    expect(page).to have_selector '#notice', text: t('check_password_reset_email')
    visit email_link
    expect(page).to have_selector '#notice', text: t('please_set_password')
    fill_in 'password', with: 'new-password'
    fill_in 'password_confirmation', with: 'new-password'
    click_on t('reset_password')
    expect(page).to have_selector '#notice', text: t('password_reset_success')
  end

  scenario 'reset password failed (not found email)' do
    visit new_password_reset_path
    fill_in 'email', with: 'hogehoge'
    click_on t('reset_password')
    expect(page).to have_selector '#alert', text: t('not_found_email')
  end
end

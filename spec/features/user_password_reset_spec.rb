require 'rails_helper'

RSpec.feature "UserPasswordResets", type: :feature do
  let(:user) { create(:user, activated: true) }

  scenario 'valid password reset' do
    visit new_password_reset_path
    fill_in 'password_reset[email]', with: user.email
    click_button I18n.t('password_resets.new_form.submit')
    expect(page).to have_selector 'div#notice'
    visit password_reset_email_link
    fill_in 'user[password]', with: 'new_password'
    fill_in 'user[password_confirmation]', with: 'new_password'
    click_button I18n.t('password_resets.edit_form.submit')
    expect(page).to have_selector 'div#notice'
  end
end

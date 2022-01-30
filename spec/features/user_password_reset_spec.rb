require 'rails_helper'

RSpec.feature "UserPasswordResets", type: :feature do
  let(:user) { create(:user, activated: true) }

  scenario 'valid password reset' do
    visit new_password_reset_path
    fill_in 'Email', with: user.email
    click_button 'Password reset'
    expect(page).to have_selector 'div#notice'
    visit password_reset_email_link
    fill_in 'Password', with: 'new_password'
    fill_in 'Password confirmation', with: 'new_password'
    click_button 'Password reset'
    expect(page).to have_selector 'div#notice'
  end
end

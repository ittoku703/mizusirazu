require 'rails_helper'

RSpec.feature 'Unlocks', type: :feature do
  let(:user) { create(:user) }
  scenario 'warning -> lock -> unlock' do
    visit new_user_session_path
    # warning !!!
    19.times { failed_login }
    expect(page).to have_content 'あなたのアカウントが凍結される前に、複数回の操作がおこなわれています。'
    # user locked and send email for unlock
    failed_login
    expect(page).to have_content 'あなたのアカウントは凍結されています。'
    # unlock !!!
    visit_email_link_url
    expect(page).to have_content 'アカウントを凍結解除しました。'
  end

  scenario 'unlock page element check' do
    visit new_user_unlock_path
    expect(page).to have_content 'Resend unlock instructions'
    expect(page).to have_selector 'input#user_email'
    expect(page).to have_button 'Resend unlock instructions'
    expect(page).to have_link 'Log in'
    expect(page).to have_link 'Sign up'
    expect(page).to have_link 'Forgot your password?'
    expect(page).to have_link 'Didn\'t receive confirmation instructions?'
  end
end

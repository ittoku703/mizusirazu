require 'rails_helper'

RSpec.feature "Confirmations", type: :feature do
  let(:user) { create(:user, confirmed_at: nil) }
  background { visit new_user_confirmation_path }
  scenario 'user confirmation' do
    fill_in 'Email', with: user.email
    click_button 'Resend confirmation instructions'
    expect(page).to have_content 'アカウントの有効化について数分以内にメールでご連絡します。'
    visit_email_link_url
    expect(page).to have_content 'アカウントを登録しました。'
    expect(page).to have_content user.name # user_signed_in?
  end

  scenario 'confirmation page element check' do
    expect(page).to have_content 'Resend confirmation instructions'
    expect(page).to have_selector 'input#user_email'
    expect(page).to have_button 'Resend confirmation instructions'
    expect(page).to have_link 'Log in'
    expect(page).to have_link 'Sign up'
    expect(page).to have_link 'Forgot your password?'
  end
end

require 'rails_helper'

RSpec.feature 'Signups', type: :feature do
  let(:user) { build(:user) }

  scenario 'signup' do
    visit new_user_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password_confirmation
    click_button t('signup')
    expect(page).to have_selector '#notice', text: 'Please check your email to activate your account'
  end

  scenario 'bad signup' do
    visit new_user_path
    fill_in 'user[email]', with: 'hogehoge'
    fill_in 'user[password]', with: 'bar'
    fill_in 'user[password_confirmation]', with: 'baz'
    click_button t('signup')
    expect(page).to have_selector '#error_explanation'
  end

  scenario 'activation' do
    visit new_user_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password_confirmation
    click_button t('signup')
    expect(page).to have_selector '#notice', text: 'Please check your email to activate your account'
    # needed_activation_email
    visit email_link
    expect(page).to have_selector '#notice', text: 'Successfully activated'
    # success activation email
    mail = ActionMailer::Base.deliveries.last
    expect(mail.subject).to eq "#{user.email} is now activated"
  end
end

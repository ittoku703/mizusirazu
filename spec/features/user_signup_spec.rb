require 'rails_helper'

RSpec.feature 'UserSignup', type: :feature do
  let(:user_params) { attributes_for(:user) }

  scenario 'valid sign up' do
    visit new_user_path()
    fill_in 'Name', with: user_params[:name]
    fill_in 'Email', with: user_params[:email]
    fill_in 'Password', with: user_params[:password]
    fill_in 'Password confirmation', with: user_params[:password]
    click_button 'Sign up'
    expect(page).to have_selector 'div#notice'
    visit activation_email_link
    expect(page).to have_selector 'div#notice'
  end

  scenario 'invalid sign up' do
    visit new_user_path()
    fill_in 'Name', with: 'hogebar'
    fill_in 'Email', with: 'hoge@bar'
    fill_in 'Password', with: 'hoge'
    fill_in 'Password confirmation', with: 'bar'
    click_button 'Sign up'
    expect(page).to have_selector 'div#error_explanation'
  end

  scenario 'already log in user sign up' do
    log_in_as(create(:user))
    visit new_user_path()
    expect(page).to have_selector 'div#notice'
  end
end

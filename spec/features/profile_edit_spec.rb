require 'rails_helper'

RSpec.feature "ProfileEdits", type: :feature do
  let(:user) { create(:user) }
  let(:profile_params) { attributes_for(:profile) }

  scenario 'valid profile' do
    log_in_as(user)
    visit edit_user_profile_path
    fill_in 'Name', with: profile_params[:name]
    fill_in 'Bio', with: profile_params[:bio]
    fill_in 'Location', with: profile_params[:location]
    click_button 'Update profile'
    expect(page).to have_selector 'div#notice'
  end

  scenario 'invalid profile' do
    log_in_as(user)
    visit edit_user_profile_path
    fill_in 'Name', with: 'invalid' * 100
    fill_in 'Bio', with: 'invalid' * 200
    fill_in 'Location', with: 'unknown' * 100
    click_button 'Update profile'
    expect(page).to have_selector 'div#error_explanation'
  end

  scenario 'non logged in user profile' do
    visit edit_user_profile_path
    expect(page).to have_selector 'div#alert'
  end
end

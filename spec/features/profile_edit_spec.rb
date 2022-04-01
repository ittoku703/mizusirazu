require 'rails_helper'

RSpec.feature "ProfileEdits", type: :feature do
  let(:user) { create(:user) }
  let(:profile_params) { attributes_for(:profile) }

  scenario 'valid profile' do
    activate_as(user)
    visit edit_user_profile_path
    fill_in 'profile[name]', with: profile_params[:name]
    fill_in 'profile[bio]', with: profile_params[:bio]
    fill_in 'profile[location]', with: profile_params[:location]
    click_button I18n.t('profiles.form.update_profile')
    expect(page).to have_selector 'div#notice'
  end

  scenario 'invalid profile' do
    activate_as(user)
    visit edit_user_profile_path
    fill_in 'profile[name]', with: 'invalid' * 100
    fill_in 'profile[bio]', with: 'invalid' * 200
    fill_in 'profile[location]', with: 'unknown' * 100
    click_button I18n.t('profiles.form.update_profile')
    expect(page).to have_selector 'div#error_explanation'
  end

  scenario 'non logged in user profile' do
    visit edit_user_profile_path
    expect(page).to have_selector 'div#alert'
  end
end

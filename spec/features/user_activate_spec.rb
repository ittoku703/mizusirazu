require 'rails_helper'

RSpec.feature "UserActivates", type: :feature do
  let(:user) { create(:user) }

  scenario 'valid activate' do
    visit new_account_activation_path
    fill_in 'Email', with: user.email
    click_button 'Activate'
    expect(page).to have_selector 'div#notice'
    visit activation_email_link
    expect(page).to have_selector 'div#notice'
  end

  scenario 'invalid activate' do
    visit new_account_activation_path
    fill_in 'Email', with: 'hogebar'
    click_button 'Activate'
    expect(page).to have_selector 'div#alert'
  end

  scenario 'activate user activate' do
    activate_as(user)
    visit new_account_activation_path
    expect(page).to have_selector 'div#notice'
  end
end

require 'rails_helper'

RSpec.feature "UserActivates", type: :feature do
  let!(:user) { create(:user) }

  background do
    sleep 1 # wait 1 second because can not send an email twice in one second.
  end

  scenario 'valid activate' do
    visit new_account_activation_path
    fill_in 'account_activation[email]', with: user.email
    click_button I18n.t('account_activations.new_form.send_email')
    expect(page).to have_selector 'div#notice'
    visit activation_email_link
    expect(page).to have_selector 'div#notice'
  end

  scenario 'invalid activate' do
    visit new_account_activation_path
    fill_in 'account_activation[email]', with: 'hogebar'
    click_button I18n.t('account_activations.new_form.send_email')
    expect(page).to have_selector 'div#alert'
  end

  scenario 'activate user activate' do
    activate_as(user)
    visit new_account_activation_path
    expect(page).to have_selector 'div#notice'
  end
end

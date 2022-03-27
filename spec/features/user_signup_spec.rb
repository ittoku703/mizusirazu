require 'rails_helper'

RSpec.feature 'UserSignup', type: :feature do
  let(:user_params) { attributes_for(:user) }

  scenario 'valid sign up' do
    visit new_user_path()
    fill_in I18n.t('activerecord.attributes.user.name'),                  with: user_params[:name]
    fill_in I18n.t('activerecord.attributes.user.email'),                 with: user_params[:email]
    fill_in I18n.t('activerecord.attributes.user.password'),              with: user_params[:password]
    fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: user_params[:password]
    click_button 'Sign up'
    expect(page).to have_selector 'div#notice'
    visit activation_email_link
    expect(page).to have_selector 'div#notice'
  end

  scenario 'invalid sign up' do
    visit new_user_path()
    fill_in I18n.t('activerecord.attributes.user.name'),                  with: 'hogebar'
    fill_in I18n.t('activerecord.attributes.user.email'),                 with: 'hoge@bar.com'
    fill_in I18n.t('activerecord.attributes.user.password'),              with: 'hoge'
    fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: 'bar'
    click_button 'Sign up'
    expect(page).to have_selector 'div#error_explanation'
  end

  scenario 'already log in user sign up' do
    log_in_as(create(:user))
    visit new_user_path()
    expect(page).to have_selector 'div#notice'
  end
end

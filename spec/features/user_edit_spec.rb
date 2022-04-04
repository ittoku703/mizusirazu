require 'rails_helper'

RSpec.feature 'UserEdit', type: :feature do
  let(:user) { create(:user) }

  scenario 'valid user settings' do
    activate_as(user)
    visit edit_user_path()
    fill_in 'user[name]',       with: 'update_user'
    fill_in 'user[email]',      with: user.email
    click_button I18n.t('users.form.update_user')
    expect(page).to have_selector 'div#notice'
  end

  scenario 'invalid user settings' do
    activate_as(user)
    visit edit_user_path()
    fill_in 'user[name]',  with: 'hoge'
    fill_in 'user[email]', with: 'bar'
    click_button I18n.t('users.form.update_user')
    expect(page).to have_selector 'div#error_explanation'
  end

  scenario 'non logged in user settings' do
    visit edit_user_path()
    expect(page).to have_selector 'div#alert'
  end

  scenario 'user email changed' do
    activate_as(user)
    visit edit_user_path()
    fill_in 'user[name]',  with: 'update_user'
    fill_in 'user[email]', with: 'email@changed.com'
    click_button I18n.t('users.form.update_user')
    expect(page).to have_selector 'div#notice'
    visit activation_email_link()
    expect(page).to have_selector 'div#notice'
  end
end

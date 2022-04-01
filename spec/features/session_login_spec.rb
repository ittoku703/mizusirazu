require 'rails_helper'

RSpec.feature "SessionLogins", type: :feature do
  let(:user) { create(:user, activated: true) }

  scenario 'valid login' do
    visit new_session_path
    fill_in 'session[name_or_email]', with: user.name
    fill_in 'session[password]', with: 'password'
    check I18n.t('sessions.form.save_the_login')
    click_button I18n.t('sessions.new.title')
    expect(page).to have_selector 'div#notice'
  end

  scenario 'invalid login' do
    visit new_session_path
    fill_in 'session[name_or_email]', with: 'hoge'
    fill_in 'session[password]', with: 'bar'
    check I18n.t('sessions.form.save_the_login')
    click_button I18n.t('sessions.new.title')
    expect(page).to have_selector 'div#alert'
    expect(page).to have_field 'session[name_or_email]', with: 'hoge'
  end

  scenario 'logged in user login' do
    log_in_as(user)
    visit new_session_path
    expect(page).to have_selector 'div#notice'
  end
end

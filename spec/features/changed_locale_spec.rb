require 'rails_helper'

RSpec.feature "ChangedLocale", type: :feature do
  scenario 'changed locale' do
    visit root_path
    click_link t('ja')
    expect(I18n.locale).to eq :ja
    # if you change the page, keep the language the same
    visit new_user_session_path
    expect(I18n.locale).to eq :ja
  end
end

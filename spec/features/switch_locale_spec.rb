require 'rails_helper'

RSpec.feature 'SwitchLocales', type: :feature do
  scenario 'switch locale' do
    visit root_path
    click_link t('en')
    expect(I18n.locale).to eq :en
    click_link t('ja')
    expect(I18n.locale).to eq :ja
  end
end

require 'rails_helper'

RSpec.feature "ProviderLogins", type: :feature do
  scenario 'twitter login' do
    twitter_mock()
    visit new_session_path()
    find('button[alt="twitter"]').click
    expect(page).to have_selector 'div#notice'
  end

  scenario 'github login' do
    github_mock()
    visit new_session_path()
    find('button[alt="github"]').click
    expect(page).to have_selector 'div#notice'
  end

  scenario 'twitter login failed' do
    twitter_invalid_credentials()
    visit new_session_path()
    find('button[alt="twitter"]').click
    expect(page).to have_selector 'div#alert'
  end
end

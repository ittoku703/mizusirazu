require 'rails_helper'

RSpec.feature 'MicropostCreates', type: :feature do
  let!(:user) { create(:user) }

  scenario 'create micropost' do
    log_in_as(user)
    visit new_micropost_path()
    fill_in 'Title', with: 'This is Title'
    fill_in 'Content', with: 'This is Content'
    click_button 'Create Micropost'
    expect(page).to have_selector('div#notice')
  end

  scenario 'invalid create micropost' do
    log_in_as(user)
    visit new_micropost_path()
    fill_in 'Title', with: ''
    fill_in 'Content', with: ''
    click_button 'Create Micropost'
    expect(page).to have_selector('div#error_explanation')
  end

  scenario 'non logged in user create micropost' do
    visit new_micropost_path()
    expect(page).to have_selector('div#alert')
  end
end

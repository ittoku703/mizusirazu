require 'rails_helper'

RSpec.feature 'MicropostEdits', type: :feature do
  let!(:micropost) { create(:micropost) }
  let!(:other_user) { create(:other_user) }

  scenario 'edit micropost' do
    log_in_as(micropost.user)
    visit edit_micropost_path(micropost)
    fill_in 'Title', with: 'Edit micropost title'
    fill_in 'Content', with: 'Edit micropost content'
    click_button 'Edit Micropost'
    expect(page).to have_selector('div#notice')
  end

  scenario 'invalid edit micropost' do
    log_in_as(micropost.user)
    visit edit_micropost_path(micropost)
    fill_in 'Title', with: ''
    fill_in 'Content', with: ''
    click_button 'Edit Micropost'
    expect(page).to have_selector('div#alert')
  end

  scenario 'non logged in user edit micropost' do
    visit edit_micropost_path(micropost)
    expect(page).to have_selector('div#alert')
  end

  scenario 'other user edit micropost' do
    visit edit_micropost_path(micropost)
    expect(page).to have_selector('div#alert')
  end
end

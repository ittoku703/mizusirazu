require 'rails_helper'

RSpec.feature 'MicropostCreates', type: :feature do
  let!(:user) { create(:user) }

  scenario 'create micropost' do
    log_in_as(user)
    visit new_micropost_path()
    attach_file 'micropost[images][]', 'spec/fixtures/files/test.png'
    fill_in 'micropost[title]', with: 'This is Title'
    fill_in 'micropost[content]', with: 'This is Content'
    click_button I18n.t('microposts.new_form.create_micropost')
    expect(page).to have_selector('div#notice')
    expect(page).to have_selector('img[alt="micropost_image"]')
  end

  scenario 'invalid create micropost' do
    log_in_as(user)
    visit new_micropost_path()
    fill_in 'micropost[title]', with: ''
    fill_in 'micropost[content]', with: ''
    click_button I18n.t('microposts.new_form.create_micropost')
    expect(page).to have_selector('div#error_explanation')
  end

  scenario 'non logged in user create micropost' do
    visit new_micropost_path()
    expect(page).to have_selector('div#alert')
  end
end

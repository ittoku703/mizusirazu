require 'rails_helper'

RSpec.feature 'Microposts', type: :feature do
  let(:user) { create(:user) }
  let(:micropost) { user.microposts.create(attributes_for(:micropost)) }

  scenario 'create micropost' do
    login_user
    visit new_micropost_path
    # failed
    fill_in 'micropost[title]', with: ''
    fill_in 'micropost[content]', with: ''
    click_button t('post')
    expect(page).to have_selector('#error_explanation')
    # success
    fill_in 'micropost[title]', with: 'Title'
    fill_in 'micropost[content]', with: 'This is content.'
    attach_file t('select_file'), 'spec/factories/images/test.gif'
    click_button t('post')
    expect(page).to have_selector('#notice', text: t('microposts.success'))
    expect(page).to have_selector 'img[alt="micropost images"]'
  end

  scenario 'edit micropost' do
    login_user
    visit edit_micropost_path(micropost)
    # failed
    fill_in 'micropost[title]', with: ''
    fill_in 'micropost[content]', with: ''
    click_button t('edit')
    expect(page).to have_selector('#error_explanation')
    # success
    fill_in 'micropost[title]', with: 'new Title'
    fill_in 'micropost[content]', with: 'new content.'
    attach_file t('select_file'), 'spec/factories/images/test.gif'
    click_button t('edit')
    expect(page).to have_selector('#notice', text: t('microposts.updated'))
    expect(page).to have_selector 'img[alt="micropost images"]'
  end

  scenario 'delete micropost' do
    login_user
    visit edit_micropost_path(micropost)
    click_link t('delete')
    expect(page).to have_selector('#notice', text: t('microposts.deleted'))
  end
end

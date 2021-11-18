require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost) }

  scenario 'comment', js: true do
    I18n.default_locale = :ja # <-- nessally
    login_user
    visit micropost_path(micropost)
    # new comment
    fill_in 'comment[content]', with: 'first comment'
    click_button t('post')
    expect(page).to have_content 'first comment'
    # edit comment
    click_button t('edit_comment')
    fill_in 'comment[content]', with: 'edit comment', match: :first
    click_button t('edit')
    expect(page).to have_content 'edit comment'
    # delete comment
    click_link t('delete')
    page.driver.browser.switch_to.alert.accept
    expect(page).not_to have_content 'edit comment'
  end

  scenario 'no comment form non logged in user' do
    visit micropost_path(micropost)
    expect(page).not_to have_selector 'form#new_comment'
  end

  scenario 'no send comment if comment content is nil' do
    login_user
    visit micropost_path(micropost)
    fill_in 'comment[content]', with: ''
    click_button t('post')
    expect(Comment.count).to eq 0
  end
end

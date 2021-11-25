require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost, user: user) }

  scenario 'comment', js: true do
    I18n.default_locale = :ja # <-- nessally
    login_user
    visit micropost_path(micropost)
    # new comment
    fill_in 'comment[content]', with: 'first comment'
    attach_file t('select_file'), 'spec/factories/images/test.gif', make_visible: true
    click_button t('post')
    expect(page).to have_content 'first comment'
    expect(page).to have_selector 'img[alt="comment images"]'
    # edit comment
    click_button t('edit_comment')
    fill_in 'comment[content]', with: 'edit comment', match: :first
    attach_file t('select_file'), 'spec/factories/images/test.png', make_visible: true, match: :first
    click_button t('edit')
    expect(page).to have_content 'edit comment'
    expect(page).to have_selector 'img[alt="comment images"]'
    # delete comment
    click_link t('delete')
    page.driver.browser.switch_to.alert.accept
    expect(page).not_to have_content 'edit comment'
    expect(page).not_to have_selector 'img[alt="comment images"]'
  end

  scenario 'no comment form non logged in user' do
    visit micropost_path(micropost)
    expect(page).not_to have_selector 'form#new_comment'
  end
end

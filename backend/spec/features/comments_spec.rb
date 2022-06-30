require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  let!(:micropost) { create(:micropost) }
  let!(:user)      { micropost.user }

  scenario 'create comment' do
    log_in_as(user)
    visit micropost_path(micropost)
    fill_in 'comment[content]', with: 'create comment!'
    click_button I18n.t('comments.new_form.submit')
    expect(page).to have_selector 'div#notice'
    expect(page).to have_content 'create comment!'
  end

  scenario 'update comment' do
    log_in_as(user)
    user.comments.create!(content: 'create comment!', micropost_id: micropost.id)
    visit micropost_path(micropost)
    fill_in 'comment[content]', with: 'update comment!', match: :first
    click_button I18n.t('comments.edit_form.update_submit')
    expect(page).to have_selector 'div#notice'
    expect(page).to have_content 'update comment!'
  end

  scenario 'delete comment', js: true do
    log_in_as(user) and sleep(1)
    user.comments.create!(content: 'create comment!', micropost_id: micropost.id)
    visit micropost_path(micropost)
    click_link(I18n.t('comments.edit_form.delete_submit')) and page.accept_confirm()
    expect(page).to have_selector 'div#notice'
    expect(page).not_to have_content 'create comment!'
  end
end

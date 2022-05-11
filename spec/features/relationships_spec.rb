require 'rails_helper'

RSpec.feature 'Relationships', type: :feature do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:other_user) }

  scenario 'follow other_user' do
    log_in_as(user)
    visit user_path(other_user)
    # follow
    click_button I18n.t('relationships.page.follow')
    expect(page).to have_selector('div#notice')
    # unfollow
    click_button I18n.t('relationships.page.unfollow')
    expect(page).to have_selector('div#notice')
  end

  scenario 'follow other_user when non logged in user' do
    visit user_path(other_user)
    expect(page).not_to have_content(I18n.t('relationships.page.follow'))
  end
end

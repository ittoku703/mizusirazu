require 'rails_helper'

RSpec.feature 'UserDelete', type: :feature do
  let(:user) { create(:user) }

  scenario 'user delete', js: true do
    log_in_as(user) and sleep 1
    visit edit_user_path()
    click_link I18n.t('users.edit_form.delete_user') and page.accept_confirm
    expect(page).not_to have_selector 'div#notice'
  end
end

require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
  scenario 'contact', js: true do
    visit contact_path()
    # failed
    click_button I18n.t('static_pages.contact.submit') and page.accept_confirm()
    expect(page).to have_selector 'div#alert'
    # success
    fill_in 'contact[reply_email]', with: 'valid@email.com'
    fill_in 'contact[content]', with: 'hello!!'
    click_button I18n.t('static_pages.contact.submit') and page.accept_confirm()
    expect(page).to have_selector 'div#notice'
  end
end

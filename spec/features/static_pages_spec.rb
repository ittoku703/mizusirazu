require 'rails_helper'

# REQUIRED: selenium-webdriber
#
# RSpec.feature "StaticPages", type: :feature do
#   scenario 'contact' do
#     visit contact_path()
#     # failed
#     click_button I18n.t('static_pages.contact.submit')
#     expect(page).to have_selector 'div#alert'
#     # success
#     fill_in 'contact[reply_email]', with: 'valid@email.com'
#     fill_in 'contact[content]', with: 'hello!!'
#     click_button I18n.t('static_pages.contact.submit')
#     expect(page).to have_selector 'div#notice'
#   end
# end

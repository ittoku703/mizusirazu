require 'rails_helper'

# REQUIRED: selenium-driver
#
# RSpec.feature 'Microposts', type: :feature, js: true do
#   context 'Create' do
#     let!(:user) { create(:user) }

#     scenario 'create micropost' do
#       log_in_as(user)
#       visit new_micropost_path()
#       attach_file 'micropost[images][]', 'spec/fixtures/files/test.png'
#       fill_in 'micropost[title]', with: 'This is Title'
#       fill_in_rich_text_area 'micropost_content', with: 'This is Content'
#       click_button I18n.t('microposts.new_form.create_micropost')
#       expect(page).to have_selector('div#notice')
#       expect(page).to have_selector('img[alt="micropost_image"]')
#     end

#     scenario 'invalid create micropost' do
#       log_in_as(user)
#       visit new_micropost_path()
#       fill_in 'micropost[title]', with: ''
#       fill_in_rich_text_area 'micropost_content', with: ''
#       click_button I18n.t('microposts.new_form.create_micropost')
#       expect(page).to have_selector('div#error_explanation')
#     end

#     scenario 'non logged in user create micropost' do
#       visit new_micropost_path()
#       expect(page).to have_selector('div#alert')
#     end
#   end

#   context 'Update' do
#     let!(:micropost) { create(:micropost) }
#     let!(:other_user) { create(:other_user) }

#     scenario 'edit micropost' do
#       log_in_as(micropost.user)
#       visit edit_micropost_path(micropost)
#       attach_file 'micropost[images][]', 'spec/fixtures/files/test.png'
#       fill_in 'micropost[title]', with: 'Edit micropost title'
#       fill_in_rich_text_area 'micropost_content', with: 'Edit micropost content'
#       click_button I18n.t('microposts.edit_form.update_micropost')
#       expect(page).to have_selector('div#notice')
#       expect(page).to have_selector('img[alt="micropost_image"]')
#     end

#     scenario 'invalid edit micropost' do
#       log_in_as(micropost.user)
#       visit edit_micropost_path(micropost)
#       fill_in 'micropost[title]', with: ''
#       fill_in_rich_text_area 'micropost_content', with: ''
#       click_button I18n.t('microposts.edit_form.update_micropost')
#       expect(page).to have_selector('div#error_explanation')
#     end

#     scenario 'non logged in user edit micropost' do
#       visit edit_micropost_path(micropost)
#       expect(page).to have_selector('div#alert')
#     end

#     scenario 'other user edit micropost' do
#       visit edit_micropost_path(micropost)
#       expect(page).to have_selector('div#alert')
#     end
#   end

#   context 'Delete' do
#     let!(:micropost) { create(:micropost) }

#     scenario 'delete micropost' do
#       log_in_as(micropost.user)
#       visit micropost_path(micropost)
#       click_link I18n.t('microposts.show.delete_micropost')
#       page.accept_confirm
#       expect(page).to have_selector('div#notice')
#     end
#   end
# end

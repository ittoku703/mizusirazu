require 'rails_helper'

RSpec.feature "registration user", type: :feature do
  let(:user) { build(:user) }
  scenario 'signup -> edit -> delete' do
    # sign up user !!!
    visit new_user_registration_path
    fill_in "Name", with: user.name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    click_button 'Sign up'
    expect(page).to have_content 'アカウント登録が完了しました。'
    # edit user !!!
    visit edit_user_registration_path
    fill_in "Name", with: user.name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    fill_in "Current password", with: user.password
    click_button "Update"
    expect(page).to have_content "アカウント情報を変更しました。"
    # delete user !!!
    visit edit_user_registration_path
    click_button "Cancel my account"
    expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
  end

  scenario "signup page element check" do
    visit new_user_registration_path
    expect(page).to have_content "Sign up"
    expect(page).to have_selector 'input#user_name'
    expect(page).to have_selector 'input#user_email'
    expect(page).to have_selector 'input#user_password'
    expect(page).to have_selector 'input#user_password_confirmation'
    expect(page).to have_link "Log in"
  end

  scenario "edit page element check" do
    login_as build(:user)
    visit edit_user_registration_path
    expect(page).to have_content "Edit User"
    expect(page).to have_selector 'input#user_name'
    expect(page).to have_selector 'input#user_email'
    expect(page).to have_selector 'input#user_password'
    expect(page).to have_selector 'input#user_password_confirmation'
    expect(page).to have_selector 'input#user_current_password'
    expect(page).to have_button "Update"
    expect(page).to have_button 'Cancel my account'
    expect(page).to have_link "Back"
  end
end

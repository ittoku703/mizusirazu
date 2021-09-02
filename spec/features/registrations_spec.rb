require 'rails_helper'

RSpec.feature "registration user", type: :feature do
  let(:user) { build(:user) }
  scenario 'signup -> confirm -> edit -> delete' do
    # sign up user !!!
    visit new_user_registration_path
    fill_in "Name", with: user.name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    click_button 'Sign up'
    expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
    # confirm user !!!
    visit_email_link_url
    expect(page).to have_content 'アカウントを登録しました。'
    # edit user !!!
    click_link 'Settings'
    fill_in "Name", with: user.name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    fill_in "Current password", with: user.password
    click_button "Update"
    expect(page).to have_content "アカウント情報を変更しました。"
    # delete user !!!
    click_link 'Settings'
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
    expect(page).to have_link 'Didn\'t receive confirmation instructions?'
    expect(page).to have_link 'Didn\'t receive unlock instructions?'
  end

  scenario 'show page element check' do
    login_user
    visit user_path
    expect(page).to have_content user.name
    expect(page).to have_content "Email: #{user.email}"
    expect(page).to have_content "Sign in count: #{user.sign_in_count}"
  end

  scenario "edit page element check" do
    login_user
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

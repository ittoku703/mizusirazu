module FeatureSupport
  def log_in_as(user)
    visit new_session_path()
    fill_in 'Name or email', with: user.name
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end
end
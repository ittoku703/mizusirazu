require "test_helper"

class UsersProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test 'valid profile' do
    log_in_as(@user)
    get edit_user_profile_path
    patch user_profile_path(@user, @user.profile), params: { profile: {
      name: 'mr. john dou',
      bio: 'hello im john!',
      location: 'US'
    }}
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div#notice'
  end

  test 'invalid profile' do
    log_in_as(@user)
    get edit_user_profile_path
    patch user_profile_path(@user, @user.profile), params: { profile: {
      name: 'invalid name' * 100,
      bio: 'invalid',
      location: 'error!!!'
    }}
    assert_template 'profiles/edit'
    assert_select 'div#error_explanation'
  end

  test 'non logged in user access to profile page' do
    get edit_user_profile_path
    follow_redirect!
    assert_template 'sessions/new'
    assert_select 'div#alert'
  end
end

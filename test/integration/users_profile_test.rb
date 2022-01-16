require "test_helper"

class UsersProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test 'valid profile' do
    log_in_as(@user)
    get user_profiles_path(@user)
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
    get user_profiles_path(@user)
    patch user_profile_path(@user, @user.profile), params: { profile: {
      name: 'invalid name' * 100,
      bio: 'invalid',
      location: 'error!!!'
    }}
    assert_template 'profiles/index'
    assert_select 'div#error_explanation'
  end

  test 'non logged in user access to profile page' do
    get user_profiles_path(@user)
    follow_redirect!
    assert_template 'sessions/new'
    assert_select 'div#alert'
  end
end

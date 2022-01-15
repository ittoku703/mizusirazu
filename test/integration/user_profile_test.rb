require "test_helper"

class UserProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test 'invalid profile' do
    get user_profiles_path(@user)
    patch user_profile_path(@user, @user.profile), params: { profile: {
      name: 'invalid name' * 100,
      bio: 'invalid',
      location: 'error!!!'
    }}
    assert_template 'profiles/index'
    assert_select 'div#error_explanation'
  end

  test 'valid profile' do
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
end

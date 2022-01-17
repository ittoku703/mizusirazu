require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @profile_params = { profile: {
      name: 'NickName',
      bio: 'Hello! i am Example user!!',
      location: 'US'
    } }
  end

  test "should get index when logged in user" do
    log_in_as(@user)
    get edit_user_profile_path
    assert_response :success
  end

  test 'should be redirect to user page when logged in user' do
    log_in_as(@user)
    patch user_profile_path(@user, @user.profile), params: @profile_params
    assert_redirected_to user_path(@user)
  end

  test 'should redirect to login page when user not logged in' do
    patch user_profile_path(@user, @user.profile), params: @profile_params
    assert_redirected_to new_session_path
  end

  test 'should be update when logged in user' do
    log_in_as(@user)
    @profile_params[:profile][:name] = 'successfully, updated!!!'
    patch user_profile_path(@user, @user.profile), params: @profile_params
    assert_equal @profile_params[:profile][:name], @user.reload.profile.name
  end

  test 'should redirect to user page when logged in user' do
    log_in_as(@user)
    patch user_profile_path(@user, @user.profile), params: @profile_params
    assert_redirected_to @user
  end

  test 'if profile params is invalid, should render edit' do
    log_in_as(@user)
    invalid_profile_params = { profile: {
      name: 'x' * 1234,
      bio: 'invalid' * 200,
      location: 'unknown'
    } }
    patch user_profile_path(@user, @user.profile), params: invalid_profile_params
    assert_template :edit
  end

  test 'should redirect to login page when non logged in user' do
    patch user_profile_path(@user, @user.profile), params: @profile_params
    assert_redirected_to new_session_path
  end
end

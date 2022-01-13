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

  test "should get index" do
    get user_profiles_path(@user)
    assert_response :success
  end

  test 'should be redirect to user page' do
    post user_profiles_path @user, params: @profile_params
    assert_redirected_to user_path(@user)
  end

  test 'should be update' do
    @profile_params[:profile][:name] = 'successfully, updated!!!'
    post user_profiles_path @user, params: @profile_params
    assert_equal @profile_params[:profile][:name], @user.reload.profile.name
  end

  test 'if profile params is invalid, should render index' do
    invalid_profile_params = { profile: {
      name: 'x' * 1234,
      bio: 'invalid' * 200,
      location: 'unknown'
    } }
    post user_profiles_path @user, params: invalid_profile_params
    assert_template :index
  end
end

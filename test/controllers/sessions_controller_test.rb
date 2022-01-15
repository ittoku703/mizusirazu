require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "should get new" do
    get new_session_path
    assert_response :success
  end

  test 'should redirect to user page when user logged in' do
    post sessions_path, params: { session: {
      name_or_email: @user.name,
      password: 'password'
    } }
    assert_redirected_to @user
  end

  test 'should login user when params is valid' do
    post sessions_path, params: { session: {
      name_or_email: @user.name,
      password: 'password'
    } }
    assert is_logged_in?
  end

  test 'should rollback if params is invalid' do
    post sessions_path, params: { session: {
      name_or_email: 'hogebar',
      password: 'baz'
    }}
    assert_template :new
  end

  test 'should redirect to root when user logged out' do
    delete session_path(@user)
    assert_redirected_to root_path
  end

  test 'should log out user when params is valid' do
    log_in_as(@user)
    delete session_path(@user)
    assert_not is_logged_in?
  end
end

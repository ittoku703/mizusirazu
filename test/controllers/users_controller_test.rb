require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @user_params = { user: {
      name: 'new_user',
      email: 'new-user1234@example.com',
      password: 'password',
      password_confirmation: 'password'
    } }
  end

  test 'should get index' do
    get users_path
    assert_response :success
  end

  test 'should get new' do
    get new_user_path
    assert_response :success
  end

  test 'should redirect user page when user created' do
    post users_path, params: @user_params
    find_user = User.find_by(email: @user_params[:user][:email])
    assert_redirected_to user_path(find_user)
  end

  test 'should user count +1' do
    assert_difference('User.count', 1) do
      post users_path, params: @user_params
    end
  end

  test 'should logged in user when user created' do
    post users_path, params: @user_params
    assert is_logged_in?
  end

  test 'should rollback if create parameter is invalid' do
    post users_path, params: { user: {
      name: '',
      email: '',
      password: '',
      password_confirmation: ''
    } }
    assert_template :new
  end

  test 'should get show' do
    get user_path(@user)
    assert_response :success
  end

  test 'should get edit when logged in user' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_response :success
  end

  test 'should redirect to login when non logged in user edit' do
    get edit_user_path(@user)
    assert_redirected_to new_session_path
  end

  test 'should redirect to user page when logged in user update' do
    log_in_as(@user)
    patch user_path(@user), params: @user_params
    find_user = User.find_by(email: @user_params[:user][:email])
    assert_redirected_to user_path(find_user)
  end

  test 'should update if password is nil' do
    patch user_path @user, params: { user: {
      name: 'update_user',
      email: 'shinzanmono1192@gmail.com',
      password: ''
    } }
    assert_response :redirect
  end

  test 'should redirect to root when non logged in user update' do
    patch user_path(@user), params: @user_params
    assert_redirected_to new_session_path
  end

  test 'should rollback if update parameter is invalid' do
    log_in_as(@user)
    patch user_path(@user), params: { user: { name: '', email: '', password: '' } }
    assert_template :edit
  end

  test 'should redirect to root' do
    log_in_as(@user)
    delete user_path(@user)
    assert_redirected_to root_path
  end

  test 'should user count -1 if logged in user delete' do
    log_in_as(@user)
    assert_difference('User.count', -1) do
      delete user_path(@user)
    end
  end
end

require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test 'valid user edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), params: { user: {
      name: 'update_user',
      email: 'user@valid.com',
      password: 'password',
      password_confirmation: 'password'
    } }
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div#notice'
  end

  test 'invalid user edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), params: { user: {
      name: '',
      email: 'user@invalid',
      password: 'foo',
      password_confirmation: 'bar'
    } }
    assert_template 'users/edit'
    assert_select 'div#error_explanation'
  end

  test 'redirect to login page if user is not logged in' do
    get edit_user_path(@user)
    follow_redirect!
    assert_template 'sessions/new'
    assert_select 'div#alert'
  end
end

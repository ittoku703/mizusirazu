require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup' do
    get new_user_path
    assert_no_difference('User.count') do
      post users_path, params: { user: {
        name: '',
        email: 'user@invalid',
        password: 'foo',
        password_confirmation: 'bar'
      } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
  end

  test 'valid signup' do
    get new_user_path
    assert_difference('User.count', 1) do
      post users_path, params: { user: {
        name: 'new_user',
        email: 'user@valid.com',
        password: 'password',
        password_confirmation: 'password'
      } }
    end
    follow_redirect!
    assert is_logged_in?
    assert_template 'users/show'
    assert_select 'div#notice'
  end
end

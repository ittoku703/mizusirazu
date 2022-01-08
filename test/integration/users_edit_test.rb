require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test 'invalid user edit' do
    get edit_user_path(@user)
    patch user_path(@user), params: { user: {
      name: '',
      email: 'user@invalid',
      password: 'foo',
      password_confirmation: 'bar'
    } }
    assert_template 'users/edit'
    assert_select 'div#error_explanation h2', text: 'User form contains 4 errors'
  end

  test 'valid user edit' do
    get edit_user_path(@user)
    patch user_path(@user), params: { user: {
      name: 'new_user',
      email: 'user@valid.com',
      password: 'password',
      password_confirmation: 'password'
    } }
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div#notice span', text: 'User was successfully updated'
  end
end

require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new({
      name: 'shinzanmono_16',
      email: 'shinzanmono4649@gmail.com',
      password: 'password'
    });
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'email should be downcase before saving user' do
    mixed_case_email = 'HOGE@BAR.COM'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.email
  end

  test 'name should be present' do
    @user.name = ' '
    assert_not @user.valid?
  end

  test 'name validation should accept valid value' do
    valid_names = %w[
      shinzanmono_14
      1234asdf
      ittoku___24
    ]
    valid_names.each do |valid_name|
      @user.name = valid_name
      assert @user.valid?, "#{valid_name.inspect} should be valid"
    end
  end

  test 'name validation reject invalid value' do
    invalid_names = %w[
      HOGEHOGE_15
      aaaa:23
      bbbb-1234
      cccc1234.hoge
    ]
    invalid_names.each do |invalid_name|
      @user.name = invalid_name
      assert_not @user.valid?, "#{invalid_name.inspect} should be valid"
    end
  end

  test 'name length should be 4 characters more' do
    @user.name = 'a' * 3
    assert_not @user.valid?
  end

  test 'name length should be 128 characters less' do
    @user.name = 'a' * 129
    assert_not @user.valid?
  end

  test 'name should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'name should be allow nil' do
    @user.save
    @user.name = ''
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ' '
    assert_not @user.valid?
  end

  test 'email format should accept valid addressess' do
    valid_addresses = %w[
      hoge@bar.com
      hoge@bar.co.jp
      h_o-g_e-1.2.3.4@bar.com
    ]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address} should be valid"
    end
  end

  test 'email format should reject invalid addressess' do
    invalid_addresses = %w[
      hoge::bar@baz.com
      hoge+*&@bar.com
      hoge@bar
    ]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address} should be valid"
    end
  end

  test 'email length should be 12 more' do
    @user.email = 'h@b.com'
    assert_not @user.valid?
  end

  test 'email length should be 256 less' do
    @user.email = 'a' * 245 + '@example.com'
    assert_not @user.valid?
  end

  test 'email should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should be present' do
    @user.password = ' '
    assert_not @user.valid?
  end

  test 'password length should be 4 more' do
    @user.password = 'a' * 3
    assert_not @user.valid?
  end

  test 'password length should be 256 less' do
    @user.password = 'a' * 257
    assert_not @user.valid?
  end

  test 'profile should be destroyed when user destroyed' do
    user = users(:one)
    profile = profiles(:one)

    assert_difference('Profile.count', -1) do
      user.destroy
    end
  end
end

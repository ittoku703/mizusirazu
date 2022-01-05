require "test_helper"

class AccountTest < ActiveSupport::TestCase
  def setup
    @account = Account.new({
      username: 'shinzanmono_16',
      email: 'shinzanmono4649@gmail.com',
      password: 'password'
    });
  end

  def check_error
    @account.valid?
    puts @account.errors.full_messages
  end

  test 'should be valid' do
    check_error
    assert @account.valid?
  end

  test 'email should be downcase before saving account' do
    mixed_case_email = 'HOGE@BAR.COM'
    @account.email = mixed_case_email
    @account.save
    assert_equal mixed_case_email.downcase, @account.email
  end

  test 'username should be present' do
    @account.username = ' '
    assert_not @account.valid?
  end

  test 'username validation should accept valid value' do
    valid_usernames = %w[
      shinzanmono_14
      1234asdf
      ittoku___24
    ]
    valid_usernames.each do |valid_username|
      @account.username = valid_username
      assert @account.valid?, "#{valid_username.inspect} should be valid"
    end
  end

  test 'username validation reject invalid value' do
    invalid_usernames = %w[
      HOGEHOGE_15
      aaaa:23
      bbbb-1234
      cccc1234.hoge
    ]
    invalid_usernames.each do |invalid_username|
      @account.username = invalid_username
      assert_not @account.valid?, "#{invalid_username.inspect} should be valid"
    end
  end

  test 'username length should be 4 characters more' do
    @account.username = 'a' * 3
    assert_not @account.valid?
  end

  test 'username length should be 128 characters less' do
    @account.username = 'a' * 129
    assert_not @account.valid?
  end

  test 'username should be unique' do
    duplicate_account = @account.dup
    @account.save
    assert_not duplicate_account.valid?
  end

  test 'username should be allow nil' do
    @account.save
    @account.username = ''
    assert_not @account.valid?
  end

  test 'email should be present' do
    @account.email = ' '
    assert_not @account.valid?
  end

  test 'email format should accept valid addressess' do
    valid_addresses = %w[
      hoge@bar.com
      hoge@bar.co.jp
      h_o-g_e-1.2.3.4@bar.com
    ]
    valid_addresses.each do |valid_address|
      @account.email = valid_address
      assert @account.valid?, "#{valid_address} should be valid"
    end
  end

  test 'email format should reject invalid addressess' do
    invalid_addresses = %w[
      hoge::bar@baz.com
      hoge+*&@bar.com
      hoge@bar
    ]
    invalid_addresses.each do |invalid_address|
      @account.email = invalid_address
      assert_not @account.valid?, "#{invalid_address} should be valid"
    end
  end

  test 'email length should be 12 more' do
    @account.email = 'h@b.com' 
    assert_not @account.valid?
  end

  test 'email length should be 256 less' do
    @account.email = 'a' * 245 + '@example.com'
    assert_not @account.valid?
  end

  test 'email should be unique' do
    duplicate_account = @account.dup
    @account.save
    assert_not duplicate_account.valid?
  end

  test 'password should be present' do
    @account.password = ' '
    assert_not @account.valid?
  end

  test 'password length should be 4 more' do
    @account.password = 'a' * 3
    assert_not @account.valid?
  end

  test 'password length should be 256 less' do
    @account.password = 'a' * 257
    assert_not @account.valid?
  end
end

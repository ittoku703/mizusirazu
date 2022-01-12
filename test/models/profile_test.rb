require "test_helper"

class ProfileTest < ActiveSupport::TestCase
  def setup
    @profile = profiles(:one)
  end

  test 'should be valid' do
    assert @profile.valid?
  end

  test 'Profile should be valid when attributes is nil' do
    @profile.name = @profile.bio = @profile.location = nil
    @profile.valid?
    puts @profile.errors.full_messages
    assert @profile.valid?
  end

  test 'name should be 128 less' do
    @profile.name = 'a' * 129
    assert_not @profile.valid?
  end

  test 'bio should be 1024 less' do
    @profile.bio = 'x' * 1025
    assert_not @profile.valid?
  end

  test 'location should only accept contury-code' do
    @profile.location = 'XX'
    assert_not @profile.valid?
  end
end

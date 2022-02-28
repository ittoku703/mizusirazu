module OmniauthMocks
  # reference: https://github.com/arunagw/omniauth-twitter#authentication-hash
  def twitter_mock
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      uid: '123456',
      info: {
        nickname: 'johnqpublic',
        name: 'John Q Public',
        email: 'johnqpublic@omniauth.com',
        location: 'Anytown, USA',
        image: 'http://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png',
        description: 'a very normal guy.',
      },
      extra: {
        raw_info: {
          name: 'John Q Public',
          screen_name: 'johnqpublic',
        }
      }
    })
  end

  def twitter_invalid_credentials
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
  end
end

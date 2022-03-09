module OmniauthMocks
  # reference: https://github.com/arunagw/omniauth-twitter#authentication-hash
  def twitter_mock
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      :provider => 'twitter',
      :uid      => '123456',
      :extra    => {
        :raw_info => {
          :name              => 'mizusirazu ittoku',
          :screen_name       => 'ittoku703',
          :location          => 'japan',
          :description       => 'hello i\'m ittoku !!!',
          :profile_image_url => 'http://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png',
        }
      }
    })
  end

  def github_mock
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      :uid      => '123456',
      :extra    => {
        :raw_info => {
          :name       => 'mizusirazu ittoku',
          :login      => 'ittoku703',
          :avatar_url => 'https://avatars.githubusercontent.com/u/123456',
          :bio        => 'hello i\'m ittoku !!!',
          :location   => 'Japan',
        }
      }
    })
  end

  def twitter_invalid_credentials
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
  end

  def github_invalid_credentials
    OmniAuth.config.mock_auth[:github] = :invalid_credentials
  end
end

class Provider < ApplicationRecord
  belongs_to :user

  # if provider is found: return provider user
  # if provider is not found: create provider and user, and return user
  def Provider.find_or_create_from_auth(auth)
    if find_provider = Provider.find_by(provider: auth[:provider], uid: auth[:uid])
      return find_provider.user
    else
      User.create_from_omniauth(Provider.get_provider_hash(auth))
    end
  end

  private
    def Provider.get_provider_hash(auth)
      if auth[:provider] == 'twitter'
        return {
          provider: {
            :provider    => auth[:provider],
            :uid         => auth[:uid],
            :user_name   => auth[:extra][:raw_info][:name],
            :screen_name => auth[:extra][:raw_info][:screen_name],
            :image_url   => auth[:extra][:raw_info][:profile_image_url],
          },
          user: {
            # for the User model
            # TODO: process for now. I'll fix it later
            :name      => "#{auth[:extra][:raw_info][:login]}_#{SecureRandom.random_number(99999).to_s}",
            :email     => User.new_token + '@twitter.com',
            :password  => User.new_token,
            :activated => true,
          },
          profile: {
            :bio => auth[:extra][:raw_info][:description],
            :location    => auth[:extra][:raw_info][:location],
          }
        }
      elsif auth[:provider] == 'github'
        return {
          provider: {
            :provider    => auth[:provider],
            :uid         => auth[:uid],
            :user_name   => auth[:extra][:raw_info][:name],
            :screen_name => auth[:extra][:raw_info][:login],
            :image_url   => auth[:extra][:raw_info][:avatar_url],
          },
          user: {
            # for the User model
            # TODO: process for now. I'll fix it later
            :name      => "#{auth[:extra][:raw_info][:login]}_#{SecureRandom.random_number(99999).to_s}",
            :email     => User.new_token + '@twitter.com',
            :password  => User.new_token,
            :activated => true,
          },
          profile: {
            :bio => auth[:extra][:raw_info][:bio],
            :location    => auth[:extra][:raw_info][:location],
          }
        }
      end
    end
end

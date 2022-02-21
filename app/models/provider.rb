class Provider < ApplicationRecord
  belongs_to :user

  # if provider is found: return provider user
  # if provider is not found: create provider and user, and return user
  def Provider.find_or_create_from_auth(auth)
    provider = auth[:provider]
    screen_name = auth[:extra][:raw_info][:screen_name]
    uid = auth[:uid]
    user_name = auth[:info][:name]
    image_url = auth[:info][:image]

    if find_provider = Provider.find_by(provider: provider, uid: uid)
      return find_provider.user
    else
      user = User.create(name: uid, email: "#{uid}@twitter.com", password: User.new_token, activated: true)
      user.create_provider(provider: provider, uid: uid, user_name: user_name, image_url: image_url, screen_name: screen_name)
      return user
    end
  end
end

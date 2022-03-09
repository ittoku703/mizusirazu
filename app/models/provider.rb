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
    # for the User model
    # TODO: process for now. I'll fix it later
    name = screen_name + '_' + SecureRandom.random_number(99999).to_s
    email = User.new_token + '@twitter.com'
    # for the Profile model
    description = auth[:info][:description]
    location = auth[:info][:location]

    if find_provider = Provider.find_by(provider: provider, uid: uid)
      return find_provider.user
    else
      User.create_from_omniauth({
        user: { name: name, email: email, password: User.new_token, activated: true },
        profile: { name: user_name, bio: description, location: location },
        provider: { provider: provider, uid: uid, user_name: user_name, image_url: image_url, screen_name: screen_name }
      });
    end
  end
end

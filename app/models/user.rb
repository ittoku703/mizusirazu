class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable, :lockable, :timeoutable, :trackable, 
         :omniauthable, omniauth_providers: [:twitter]
  NAME_REGEXP = /\A^\w{4,99}$\z/
  validates :name, format: { with: NAME_REGEXP }

  def User.from_omniauth(auth)
    find_or_create_by!(provider: auth.provider, uid: auth.uid) do |user|
      user.name      = auth.info.nickname
      user.email     = auth.info.email
      user.password  = Devise.friendly_token[0, 20]
      user.image_url = auth.info.image_url
    end
  end

  def User.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.user_attributes"]
        user.attributes = params
      end
    end
  end
end

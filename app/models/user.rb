class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_one :provider, dependent: :destroy
  has_many :microposts, dependent: :destroy
  has_many :comments, dependent: :destroy

  attr_accessor :remember_token, :activation_token, :reset_token,
                :skip_create_profile_model

  before_save :downcase_email
  before_create -> { create_activation_digest_before_create() unless activated? }
  after_create ->  { create_profile_model() unless skip_create_profile_model }
  after_create ->  { send_account_activation_email() unless activated? }

  validates :name, presence: true
  validates :name,
    format: { with: /\A[a-z0-9_]+\z/, message: 'only alphabets, digits and underscore' },
    length: { maximum: 128 },
    uniqueness: true,
    allow_blank: true

  validates :email, presence: true
  validates :email,
    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
    length: { maximum: 256 },
    uniqueness: true,
    allow_blank: true

  has_secure_password

  validates :password, presence: true, on: :create
  validates :password,
    length: { in: 4..256 },
    allow_blank: true

  # return Hash values of the passed string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
      BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # return the random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # create user, profile, provider models with omniauth
  def User.create_from_omniauth(models_hash)
    # Do not create a default profile
    models_hash[:user][:skip_create_profile_model] = true

    user_model = models_hash[:user]
    profile_model = models_hash[:profile]
    provider_model = models_hash[:provider]

    user = create(user_model)
    user.create_profile(profile_model)
    user.create_provider(provider_model)
    return user
  end

  # remember user in database for permanent sessions
  def remember
    self.remember_token = User.new_token
    update(remember_digest: User.digest(remember_token))
  end

  # return true if the token passed matched digest
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # destroy the user's login information
  def forget
    update(remember_digest: nil)
  end

  # activate your account
  def activate
    update(activated: true, activated_at: Time.zone.now, activation_sent_at: nil)
  end

  # send user mailer account activation email
  def send_account_activation_email
    return if hammaring_protection(:activation_sent_at)
    create_digest(:activation)
    UserMailer.account_activation(self).deliver_now
    update(activated: false, activation_sent_at: Time.zone.now)
  end

  # send user password reset email
  def send_password_reset_email
    return if hammaring_protection(:reset_sent_at)
    create_digest(:reset)
    UserMailer.password_reset(self).deliver_now
    update(reset_sent_at: Time.zone.now)
  end

  # save digest in database for user control
  def create_digest(attribute)
    attribute_digest = "#{attribute}_digest".to_sym
    attribute_token  = "#{attribute}_token".to_sym
    self.send("#{attribute_token}=", User.new_token)
    update({ attribute_digest => User.digest(self.send(attribute_token)) })
  end

  # OVERRIDE: changed params id to params name
  def to_param
    name
  end

  private
    # make the email all downcase before saving account
    def downcase_email
      email.downcase!
    end

    # create profile after creating user
    def create_profile_model
      create_profile
    end

    # activate digest in database for email confirm
    def create_activation_digest_before_create
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

    # return if email sent twice a second
    def hammaring_protection(email_sent_at)
      self.send(email_sent_at) && self.send(email_sent_at) > 1.second.before
    end
end

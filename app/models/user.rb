class User < ApplicationRecord
  has_one :profile, dependent: :destroy

  attr_accessor :remember_token, :activation_token

  before_save :downcase_email
  before_create :create_activation_digest_before_create
  after_create :create_profile_model
  after_create :send_activation_email

  validates :name, presence: true
  # why separate it? for reduce the number of error messages
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
    update(activated: true, activated_at: Time.zone.now)
  end

  # send email for account activation
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # activate digest in database for email confirm
  def create_activation_digest
    self.activation_token = User.new_token
    update(activation_digest: User.digest(activation_token))
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
end

class User < ApplicationRecord
  has_one :profile, dependent: :destroy

  before_save :downcase_email
  after_create :create_profile_model

  validates :name, presence: true
  # why separate it? for reduce the number of error messages
  validates :name,
    format: { with: /\A[a-z0-9_]+\z/, message: 'only alphabets, digits and underscore' },
    length: { in: 4..128 },
    uniqueness: true,
    allow_blank: true

  validates :email, presence: true
  validates :email,
    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
    length: { in: 12..256 },
    uniqueness: true,
    allow_blank: true

  has_secure_password

  validates :password, presence: true, on: :create
  validates :password,
    length: { in: 4..256 },
    allow_blank: true

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
end

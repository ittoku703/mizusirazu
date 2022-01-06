class User < ApplicationRecord
  before_save :downcase_email

  validates :name,
    presence: true,
    format: { with: /\A[a-z0-9_]+\z/, message: 'only alphabets, digits and underscore' },
    length: { in: 4..128 },
    uniqueness: true,
    allow_nil: true

  validates :email,
    presence: true,
    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
    length: { in: 12..256 },
    uniqueness: true

  has_secure_password

  validates :password,
    presence: true,
    length: { in: 4..256 }

  # OVERRIDE: changed params id to params name
  def to_param
    name
  end

  private

    # make the email all downcase before saving account
    def downcase_email
      email.downcase!
    end
end

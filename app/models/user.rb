class User < ApplicationRecord
  authenticates_with_sorcery!

  NAME_REGEXP = /\A[\w+\-.\s]+\z/i
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, format: { with: EMAIL_REGEXP }, length: { maximum: 255 }, uniqueness: true
  with_options if: -> { new_record? || changes[:crypted_password] } do |user|
    user.validates :password, length: { minimum: 3 }, confirmation: true
    user.validates :password_confirmation, presence: true
  end
end

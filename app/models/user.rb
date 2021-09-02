class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  NAME_REGEXP = /\A[\w+\-.]+\z/i
  validates :name, presence: true, format: { with: NAME_REGEXP }, length: { maximum: 50 }, uniqueness: true
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: EMAIL_REGEXP }, length: { maximum: 255 }, uniqueness: true
end

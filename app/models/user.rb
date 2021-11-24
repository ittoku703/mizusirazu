class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  has_one :profile, dependent: :destroy
  has_many :microposts, dependent: :destroy
  has_many :comments, dependent: :destroy
end

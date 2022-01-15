class Profile < ApplicationRecord
  belongs_to :user

  validates :name, length: { maximum: 128 }
  validates :bio, length: { maximum: 1024 }
  validates :location, length: { maximum: 128 }
end

class Profile < ApplicationRecord
  belongs_to :user

  validates :name, length: { maximum: 100 }, allow_nil: true
  validates :bio, length: { maximum: 1000 }, allow_nil: true
  validates :location, length: { maximum: 100 }, allow_nil: true
end

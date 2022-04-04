class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar

  validates :name, length: { maximum: 128 }
  validates :bio, length: { maximum: 1024 }
  validates :location, length: { maximum: 128 }
  validates :avatar,
    content_type: { in: %w[image/jpeg image/gif image/png image/jpg] },
    size: { less_than: 5.megabytes }
end

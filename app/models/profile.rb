class Profile < ApplicationRecord
  belongs_to :user

  validates :name, length: { maximum: 128 }
  validates :bio, length: { maximum: 1024 }
  validates :location,
    # Country code represented by two letters
    inclusion: { in: ISO3166::Country.all.map(&:alpha2) },
    allow_nil: true
end

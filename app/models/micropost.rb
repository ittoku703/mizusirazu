class Micropost < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 128 }
  validates :content, presence: true, length: { maximum: 10000 }
end


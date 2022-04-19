class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many_attached :images

  default_scope -> { order(created_at: :desc) }

  has_rich_text :content

  validates :title, presence: true, length: { maximum: 128 }
  validates :content, presence: true, length: { maximum: 10000 }
  validates :images,
    content_type: { in: %w[image/jpeg image/gif image/png image/jpg], message: 'must be a valid image format' },
    size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
end

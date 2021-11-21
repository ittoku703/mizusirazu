class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost, class_name: 'Micropost'

  has_many_attached :images

  validates :micropost_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }
  validates :images, content_type: %i[png jpeg jpg gif],
                     size: { less_than: 5.megabytes },
                     limit: { max: 3 }
end

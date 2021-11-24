class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost

  has_many_attached :images

  validates :micropost_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }
  validates :images, content_type: %i[png jpeg jpg gif],
                     size: { less_than: 5.megabytes },
                     limit: { max: 3 }

  def display_images
    images.collect do |image|
      image.variant(resize: '500x500')
    end
  end
end

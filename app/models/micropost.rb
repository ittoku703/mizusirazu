class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many_attached :images

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 1000 }
  validates :images, content_type: %i[png jpeg jpg gif],
                     size: { less_than: 5.megabytes },
                     limit: { max: 10 }

  def display_images
    images.collect do |image|
      image.variant(resize: '250x250')
    end
  end
end

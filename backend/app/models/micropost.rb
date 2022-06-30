class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  has_rich_text :content

  validates :title, presence: true, length: { maximum: 128 }
  validates :content, presence: true, length: { maximum: 10000 }
end

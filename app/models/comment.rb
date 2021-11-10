class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost, class_name: 'Micropost'

  validates :micropost_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }
end

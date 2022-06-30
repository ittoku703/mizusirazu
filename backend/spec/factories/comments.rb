FactoryBot.define do
  factory :comment, class: Comment do
    content { 'test comment content 👍' }

    micropost
    user
  end
end

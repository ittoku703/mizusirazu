FactoryBot.define do
  factory :comment do
    content { 'test comment content' }

    user
    micropost
  end
end

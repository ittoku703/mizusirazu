FactoryBot.define do
  factory :comment do
    micropost
    content { Faker::Lorem.sentence(word_count: 3) }
    user
  end

  factory :other_comment do
    other_micropost
    content { Faker::Lorem.sentence(word_count: 3) }
    other
  end
end

FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence(word_count: 3) }
    micropost_id { create(:other_micropost).id }
    user_id { create(:user).id }
  end

  factory :other_comment do
    content { Faker::Lorem.sentence(word_count: 3) }
    micropost_id { create(:micropost).id }
    user_id { create(:other).id }
  end
end

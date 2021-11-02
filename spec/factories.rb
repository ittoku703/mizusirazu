FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    password { 'password' }
    password_confirmation { password }
  end

  factory :micropost do
    title { Faker::Lorem.sentence(word_count: 3) }
    content { Faker::Lorem.paragraphs }
    user_id { create(:user).id }
  end
end

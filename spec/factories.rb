FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    password { 'password' }
    password_confirmation { password }
  end

  factory :other, class: 'User' do
    email { Faker::Internet.free_email }
    password { 'password' }
    password_confirmation { password }
  end

  factory :micropost do
    title { Faker::Lorem.sentence(word_count: 3) }
    content { Faker::Lorem.paragraphs }
    user_id { create(:user).id }
  end

  factory :other_micropost, class: 'Micropost' do
    title { Faker::Lorem.sentence(word_count: 3) }
    content { Faker::Lorem.paragraphs }
    user_id { create(:other).id }
  end

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

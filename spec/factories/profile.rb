FactoryBot.define do
  factory :profile do
    name { Faker::Name.name }
    bio { Faker::Lorem.paragraph }
    location { 'en' }
    user_id { create(:user).id }
  end
end

FactoryBot.define do
  factory :user do
    name { 'test_user_01' }
    email { Faker::Internet.email }
    password { 'password' }
  end
end

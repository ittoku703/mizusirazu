FactoryBot.define do
  factory :user, class: 'User' do
    name { 'test_user_01' }
    email { Faker::Internet.email }
    password { 'password' }
  end
end

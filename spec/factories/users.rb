FactoryBot.define do
  factory :user, class: 'User' do
    name { 'test_user_01' }
    email { Faker::Internet.email }
    password { 'password' }
  end

  factory :other_user, class: 'User' do
    name { 'other_user_02' }
    email { Faker::Internet.email }
    password { 'password' }
  end
end

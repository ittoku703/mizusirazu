FactoryBot.define do
  sequence :email do
    Faker::Internet.free_email
  end

  factory :user do
    email
    password { 'password' }
    password_confirmation { password }
  end
end

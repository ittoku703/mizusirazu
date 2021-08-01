FactoryBot.define do
  factory :user do
    name  { "kazkaz" }
    email { "kaz@valid.com" }
    password              { "password" }
    password_confirmation { "password" }
    confirmed_at { Date.today }
  end
end

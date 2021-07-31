FactoryBot.define do
  factory :user do
    name  { "kazkaz" }
    email { "kaz@valid.com" }
    password              { "password" }
    password_confirmation { "password" }
  end
end

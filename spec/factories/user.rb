FactoryBot.define do
  factory :user do
    name { "shinzanmono" }
    email { "shinzanmono1192@gmail.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end

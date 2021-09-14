FactoryBot.define do
  factory :admin do
    name { 'admin' }
    email { 'admin0123@adminstrator.com' }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.zone.now }
  end

  factory :user do
    name { 'shinzanmono' }
    email { 'shinzanmono1192@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.zone.now }
  end
end

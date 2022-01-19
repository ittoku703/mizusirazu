FactoryBot.define do
  factory :profile, class: 'Profile' do
    name { 'Super man' }
    bio { 'Hi! Im test user...' }
    location { 'America' }
    user { create(:user) }
  end
end

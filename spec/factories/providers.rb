FactoryBot.define do
  factory :twitter_provider, class: Provider do
    provider { 'twitter' }
    uid { '1029384756' }
    user_name { 'john doe' }
    screen_name { 'screen_name' }
    image_url { 'image_url' }

    user
  end
end

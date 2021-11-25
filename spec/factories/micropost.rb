FactoryBot.define do
  factory :micropost do
    title { Faker::Lorem.sentence(word_count: 3) }
    content { Faker::Lorem.paragraphs }
    user
  end

  factory :other_micropost, class: 'Micropost' do
    title { Faker::Lorem.sentence(word_count: 3) }
    content { Faker::Lorem.paragraphs }
    other
  end
end

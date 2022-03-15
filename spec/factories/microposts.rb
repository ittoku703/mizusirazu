FactoryBot.define do
  factory :micropost, class: 'Micropost' do
    title { 'test title' }
    content { 'hello, this is test content 👍' }

    user
  end
end


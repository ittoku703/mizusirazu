# User.create!(email: 'example@example.com', password: 'password', password_confirmation: 'password')
# User.create!(email: 'other@other.com', password: 'password', password_confirmation: 'password')
# Micropost.create!(title: 'Example title', content: 'Example micropost', user_id: User.first.id)
# Comment.create!(micropost_id: Micropost.last.id, content: 'Example comment', user_id: User.first.id)

10.times do
  email = Faker::Internet.email
  User.create!(email: email, password: 'password', password_confirmation: 'password')
end

users = User.all
10.times do
  title = Faker::Lorem.sentence(word_count: 3)
  content = Faker::Lorem.paragraph(sentence_count: 2)
  users.each { |user| user.microposts.create!(title: title, content: content) }
end

10.times do
  content = Faker::Lorem.sentence(word_count: 3)
  users.each { |user| user.comments.create!(micropost_id: rand(1..100), content: content) }
end

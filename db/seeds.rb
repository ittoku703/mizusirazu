# User
10.times do
  email = Faker::Internet.email
  User.create!(email: email, password: 'password', password_confirmation: 'password')
end

users = User.all

# Micropost
10.times do
  users.each do |user|
    user.microposts.create!(
      title: Faker::Lorem.sentence(word_count: 3),
      content: Faker::Lorem.paragraph(sentence_count: 2)
    )
  end
end

microposts = Micropost.order("RANDOM()").limit(10)

microposts.each do |micropost|
  io = URI.open(Faker::LoremFlickr.image)
  micropost.images.attach([{io: io, filename: 'test.png'}])
end

# Comment
10.times do
  users.each do |user|
    user.comments.create!(
      micropost_id: rand(1..100),
      content:Faker::Lorem.sentence(word_count: 3)
    )
  end
end

comments = Comment.order("RANDOM()").limit(10)

comments.each do |comment|
  io = URI.open(Faker::LoremFlickr.image)
  comment.images.attach([{io: io, filename: 'test.png'}])
end


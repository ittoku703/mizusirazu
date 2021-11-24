10.times do
  # User
  user = User.create!(
    email: Faker::Internet.email,
    password: 'password'
  )

  # Profile
  user.create_profile!(
    name: Faker::Name.name,
    bio: Faker::Lorem.paragraph,
    location: Faker::Address.country
  )
end

users = User.all

# Micropost
5.times do
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
5.times do
  users.each do |user|
    user.comments.create!(
      micropost_id: rand(1..50),
      content:Faker::Lorem.sentence(word_count: 3)
    )
  end
end

comments = Comment.order("RANDOM()").limit(10)

comments.each do |comment|
  io = URI.open(Faker::LoremFlickr.image)
  comment.images.attach([{io: io, filename: 'test.png'}])
end


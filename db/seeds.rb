# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

I18n.locale = :en

puts 'Database seed start!'

# asdf creation
user = User.create!(name: 'asdf', email: 'asdf@asdf.com', password: 'password', activated: true)
user.profile.update!(name: 'Mr. asdf', bio: 'hello I\'m asdf', location: 'japan')
user.profile.avatar.attach(io: File.open('app/assets/images/logo.png'), filename: 'asdf.png', content_type: 'image/png')
user.microposts.create!(title: 'asdf introduction', content: 'hi i am asdf !!!')
user.microposts.first.images.attach(io: File.open('app/assets/images/logo.png'), filename: 'asdf.micropost.png', content_type: 'image/png')
user.comments.create!(content: 'asdf comment', micropost_id: user.microposts.first.id)

# User creation
20.times do
  user = User.create!({
    name: "#{Faker::Name.first_name.downcase}_#{Faker::Number.number(digits: 5)}",
    email: Faker::Internet.email,
    password: 'password'
  })
  puts "user_creation: #{user}"
end

users = User.all

# Profile creation
users.each do |user|
  user.profile.update!({
    name:     Faker::Name.name,
    bio:      Faker::Lorem.paragraphs.join,
    location: Faker::Address.country
  })
  puts "profile_creation: #{user.profile}"
end

# Micropost creation
users.each do |user|
  user.microposts.create!({
    title:   Faker::Lorem.sentence(word_count: 3),
    content: Faker::Lorem.paragraph(sentence_count: 2)
  })
  puts "micropost_creation: #{user.microposts.first}"
end

# Comment creation
users.each do |user|
  user.comments.create!({
    content: Faker::Lorem.sentence(),
    micropost_id: (Micropost.last.id..Micropost.first.id).to_a.sample
  })
  puts "comment_creation: #{user.comments.first}"
end

# twitter provider creation
Provider.find_or_create_from_auth({
  :provider => 'twitter',
  :uid      => '123456',
  :extra    => {
    :raw_info => {
      :name              => 'mizusirazu ittoku',
      :screen_name       => 'ittoku703',
      :location          => 'japan',
      :description       => 'hello i\'m ittoku !!!',
      :profile_image_url => 'http://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png',
    }
  }
})

# github provider creation
Provider.find_or_create_from_auth({
  :provider => 'github',
  :uid      => '123456',
  :extra    => {
    :raw_info => {
      :name       => 'mizusirazu ittoku',
      :login      => 'ittoku703',
      :avatar_url => 'https://avatars.githubusercontent.com/u/123456',
      :bio        => 'hello i\'m ittoku !!!',
      :location   => 'Japan',
    }
  }
})

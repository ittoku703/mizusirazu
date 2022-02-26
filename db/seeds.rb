# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'Database seed start!'

User.create!(name: 'asdf', email: 'asdf@asdf.com', password: 'password', activated: true)
User.first.profile.update!(name: 'Mr. asdf', bio: 'hello I\'m asdf', location: 'japan')

50.times do
  User.create!({
    name: "#{Faker::Name.first_name.downcase}_#{Faker::Number.number(digits: 5)}",
    email: Faker::Internet.email,
    password: 'password'
  })
end

puts 'user seed is done!'

User.all[1..11].each do |user|
  user.profile.update!({
    name: Faker::Name.name,
    bio: Faker::Lorem.paragraphs.join,
    location: Faker::Address.country
  })
end

puts 'profile seed is done!'

Provider.find_or_create_from_auth({
  :provider => "twitter",
  :uid => "123456",
  :info => {
    :name => "John Q Public",
    :email => "john@example.com",
    :image => "http://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png",
    :description => "Hello I\'m Jogn !",
    :location => 'US'
  },
  :extra => {
    :raw_info => {
      :screen_name => "john_q_public_12345",
    }
  }
})

puts 'provider seed is done!'

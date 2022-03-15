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

# #############
# User creation
#
50.times do
  User.create!({
    name: "#{Faker::Name.first_name.downcase}_#{Faker::Number.number(digits: 5)}",
    email: Faker::Internet.email,
    password: 'password',
    skip_create_profile_model: true
  })
end

puts 'user seed is done!'

# ################
# Profile creation
#
User.all[1..11].each do |user|
  user.profile.update!({
    name: Faker::Name.name,
    bio: Faker::Lorem.paragraphs.join,
    location: Faker::Address.country
  })
end

puts 'profile seed is done!'

# ##################
# Micropost creation
#
User.all[1..5] do |user|
  user.microposts.create!({
    title: Faker::Lorem.sentence(word_count: 3)
    content: Faker::Lorem.paragraph(sentence_count: 2)
  end
end

puts 'micropost seed is done!'

# #################
# provider creation
#
Provider.find_or_create_from_auth({
  provider: 'twitter',
  uid: '123456',
  extra: {
    raw_info: {
      name: 'John Q Public',
      screen_name: 'johnqpublic',
      location: 'Anytown, USA',
      description: 'a very normal guy.',
      profile_image_url: 'http://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png',
      email: 'johnqpublic@omniauth.com',
    }
  }
})

puts 'provider seed is done!'


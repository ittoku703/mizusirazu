# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

20.times do |i|
  name = "seed_user_#{i}"
  email = Faker::Internet.email
  User.create!(name: name, email: email, password: 'password');
end

puts 'Done! user seed'

User.all.each do |user|
  name = Faker::Name.name
  bio = Faker::Lorem.paragraphs
  location = ISO3166::Country.all.map(&:alpha2)[rand(249)]
  user.create_profile!(name: name, bio: bio, location: location)
end

puts 'Done! profile seed'

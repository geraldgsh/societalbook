# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "Batman",
  email: "batman@email.com",
  password:              "password",
  password_confirmation: "password")

User.create!(name:  "Robin",
  email: "robin@email.com",
  password:              "password",
  password_confirmation: "password")

159.times do |n|
name  = Faker::Name.name
email = "friend-#{n+1}@email.com"
password = "password"
User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do
content = Faker::Lorem.sentence(word_count: 15)
users.each { |user| user.microposts.create!(content: content) }
end

# Following relationships
users = User.all
user  = users.first
person = users[2..50]
friends = users[3..40]
person.each { |friendme| Friendship.create(user_id: user.id, friend_id: friendme.id, status: false) }
person.each { |friendme| friendme.confirm_friend(user) }
person.each { |friendme| Friendship.create(user_id: friendme.id, friend_id: user.id, status: true) }

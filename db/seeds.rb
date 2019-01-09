# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Post.destroy_all
Comment.destroy_all

10.times do
  User.create!(
          name: Faker::Name.name,
          email: Faker::Internet.email,
          password: "password1234",
          password_confirmation: "password1234"
  )
end

20.times do
  Post.create!(
          title: Faker::Book.title,
          content: Faker::Lorem.sentence
  )
end

post_ids = Post.ids

50.times do
  Comment.create!(
             post_id: post_ids.sample,
             body: Faker::Lorem.word
  )
end
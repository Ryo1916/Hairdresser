# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'securerandom'

Author.create!( name:                  "yuta arita",
                email:                 "yuta@test.abc",
                password:              "password",
                password_confirmation: "password",
                sign_in_count:         0 )

Post.create!( title:            "How to use seeds.rb?",
              body:             "Just watch your github and remember rails tutorial!",
              slug:             "",
              author_id:        1,
              published:        true,
              published_at:     Time.zone.now )

# blogs
50.times do
  six_digits = format("%0#{6}d", SecureRandom.random_number(10**6))
  Post.create!( title: Faker::Lorem.sentence,
                body: "#{Faker::Lorem.paragraph} https://images.pexels.com/photos/#{six_digits}/pexels-photo-#{six_digits}.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                slug: "",
                author_id: 1,
                published: true,
                published_at: Faker::Time.between(DateTime.now - 365, DateTime.now))
end

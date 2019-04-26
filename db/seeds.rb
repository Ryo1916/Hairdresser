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

# categories
ActsAsTaggableOn::Tag.create!( name: 'color' )
ActsAsTaggableOn::Tag.create!( name: 'cut' )
ActsAsTaggableOn::Tag.create!( name: 'styling' )
ActsAsTaggableOn::Tag.create!( name: 'perm' )
ActsAsTaggableOn::Tag.create!( name: 'care' )
ActsAsTaggableOn::Tag.create!( name: 'dryer' )
ActsAsTaggableOn::Tag.create!( name: 'blogs' )
ActsAsTaggableOn::Tag.create!( name: 'others' )

# associate categories and blogs
tags = ActsAsTaggableOn::Tag.all
posts = Post.all

for i in 0..9
  posts[i].tag_list.add(tags[0])
  posts[i].save
end

for i in 10..19
  posts[i].tag_list.add(tags[1])
  posts[i].save
end

for i in 20..29
  posts[i].tag_list.add(tags[2])
  posts[i].save
end

for i in 30..39
  posts[i].tag_list.add(tags[3])
  posts[i].save
end

for i in 40..44
  posts[i].tag_list.add(tags[4], tags[6])
  posts[i].save
end

for i in 45..49
  posts[i].tag_list.add(tags[5], tags[7])
  posts[i].save
end

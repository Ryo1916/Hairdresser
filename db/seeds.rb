# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# author
Author.create!( name:                  "yuta arita",
                email:                 "yuta@test.abc",
                password:              "password",
                password_confirmation: "password",
                sign_in_count:         0 )

# posts
Post.create!( title:            "This is my first post on this blog!",
              body:             "<p>hi world, this is my first post on this blog. I'm a Japanese hairdresser.</p>\r\n<p><img class=\"img-fluid\" src=\"https://images.pexels.com/photos/1321916/pexels-photo-1321916.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500\" alt=\"\" width=\"408\" height=\"544\" /></p>",
              slug:             "",
              author_id:        1,
              published:        true,
              published_at:     Faker::Time.between(DateTime.now - 365, DateTime.now),
              impressions_count: 0 )

Post.create!( title:            "グリーンはオススメです",
              body:             "<p>グリーンはなかなかエグいと思われる方も多いと思いますが、仕上がりは意外にスモーキーになります。</p>\r\n<p>想像されているようなエグい感じにはなりません。今年の夏オススメの色です！</p>\r\n<p><img class=\"img-fluid\" src=\"https://arine.akamaized.net/uploads/photo/external_photo/data/316244/xlarge_c5c46a6e-f7c9-4594-a95c-c92f9814cfa4.jpg\" alt=\"green color model\" width=\"408\" height=\"544\" /></p>\r\n<p>もちろん当店でも扱っていますので、気になりましたらぜひお尋ねください！</p>\r\n<p>&nbsp;</p>",
              slug:             "",
              author_id:        1,
              published:        true,
              published_at:     Time.zone.now,
              impressions_count: 0 )

for i in 1..6 do
  Post.create!( title: "色を変えました part-#{i}",
                body: "<p>今回はこんな感じ。あまり変わっていないように見えますが、よく観察するとだいぶ変わっていることがわかるかと思います。</p>\r\n<p><img class=\"img-fluid\" src=\"https://images.pexels.com/photos/973401/pexels-photo-973401.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260\" alt=\"\" width=\"408\" height=\"544\" /></p>",
                slug: "",
                author_id: 1,
                published: true,
                published_at: Faker::Time.between(DateTime.now - 365, DateTime.now),
                impressions_count: 0 )
end

# default image
Image.create!( alt: 'just the default image.',
               hint: 'default',
               file: File.open("#{Rails.root}/app/assets/images/default.jpg") )

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

posts[0].tag_list.add(tags[6], tags[7])

for i in 2..7
  posts[i].tag_list.add(tags[0], tags[1], tags[2], tags[3], tags[4], tags[5])
  posts[i].save
end

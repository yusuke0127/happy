# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

puts "Clearing database..."
Mood.destroy_all
User.destroy_all


# creating users

puts "Creating pins"
url = 'https://api.github.com/users/pins-thoo'
user_serialized = open(url).read
user = JSON.parse(user_serialized)
@pins = User.create!(
  image_url: user['avatar_url'],
  name: "Pins",
  email: "pins.thoo@gmail.com",
  password: "123456"
)
puts "Done creating pins"

puts ""
puts "Creating katsu"
url_2 = 'https://api.github.com/users/Katsulincon'
katsu_serialized = open(url_2).read
user_katsu = JSON.parse(katsu_serialized)
@katsu = User.create!(
  image_url: user_katsu['avatar_url'],
  name: "Katsu",
  email: "katsu.furugen@gmail.com",
  password: "123456"
)
puts "Done creating katsu"

puts ""
puts "Creating yusuke"
url_3 = 'https://api.github.com/users/yusuke0127'
yusuke_serialized = open(url_3).read
user_yusuke = JSON.parse(yusuke_serialized)
@yusuke = User.create!(
  image_url: user_yusuke['avatar_url'],
  name: "Yusuke",
  email: "yusuke.ishida@gmail.com",
  password: "123456"
)
puts "Done creating yusuke"

# create friendship
@pins.friend_request(@katsu)
@pins.friend_request(@yusuke)
@katsu.friend_request(@yusuke)
@katsu.accept_request(@pins)
@yusuke.accept_request(@pins)
@yusuke.accept_request(@katsu)

puts "Done creating friendship"

# creating moods

activities = %w[family friends date party netflix reading gaming relax sleep eating exercise walk meditation shopping cleaning cooking laundry work shower alcohol traveling hobbies sick movie TV arguement social\ media sex]
random_rating = [0, 1, 2, 3, 4]
bad_rating = [0, 1]

puts ""
puts "Creating random mood for pins"
400.times do
  mood_1 = Mood.new(
    rating: random_rating.sample,
    activity_list: activities.sample,
    created_at: (rand*120).days.ago
  )
  mood_1.user = @pins
  mood_1.save!
end
puts "Done creating random mood for pins"

range = (7..14)
puts ""
puts "Creating bad mood for pins"
50.times do
  mood_1 = Mood.new(
    rating: bad_rating.sample,
    activity_list: activities.sample,
    created_at: (rand(range)).days.ago
  )
  mood_1.user = @pins
  mood_1.save!
end
puts "Done creating bad mood for pins"

puts ""
puts "Creating mood for katsu"
100.times do
  mood_2 = Mood.new(
    rating: random_rating.sample,
    activity_list: activities.sample,
    created_at: (rand*120).days.ago
  )
  mood_2.user = @katsu
  mood_2.save!
end
puts "Done creating mood for katsu"

puts ""
puts "Creating mood for yusuke"
100.times do
  mood_3 = Mood.new(
    rating: random_rating.sample,
    activity_list: activities.sample,
    created_at: (rand*120).days.ago
  )
  mood_3.user = @yusuke
  mood_3.save!
end
puts "Done creating mood for yusuke"

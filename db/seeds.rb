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

puts ""
puts "Creating yann"
url_4 = 'https://api.github.com/users/yannklein'
yann_serialized = open(url_4).read
user_yann = JSON.parse(yann_serialized)
@yann = User.create!(
  image_url: user_yann['avatar_url'],
  name: "Yann",
  email: "yann.klein@gmail.com",
  password: "123456"
)
puts "Done creating yann"

puts ""
puts "Creating doug"
url_5 = 'https://api.github.com/users/dmbf29'
doug_serialized = open(url_5).read
user_doug = JSON.parse(doug_serialized)
@doug = User.create!(
  image_url: user_doug['avatar_url'],
  name: "Doug",
  email: "doug.berkley@gmail.com",
  password: "123456"
)
puts "Done creating doug"

puts ""
puts "Creating trouni"
url_6 = 'https://api.github.com/users/trouni'
trouni_serialized = open(url_6).read
user_trouni = JSON.parse(trouni_serialized)
@trouni = User.create!(
  image_url: user_trouni['avatar_url'],
  name: "Trouni",
  email: "trouni@gmail.com",
  password: "123456"
)
puts "Done creating trouni"

puts ""
puts "Creating nicole"
url_7 = 'https://api.github.com/users/reneos'
nicole_serialized = open(url_7).read
user_nicole = JSON.parse(nicole_serialized)
@nicole = User.create!(
  image_url: user_nicole['avatar_url'],
  name: "Nicole",
  email: "nicolewong@gmail.com",
  password: "123456"
)
puts "Done creating nicole"
# create friendship
@pins.friend_request(@katsu)
@pins.friend_request(@yusuke)
@katsu.friend_request(@yusuke)
@katsu.accept_request(@pins)
@yusuke.accept_request(@pins)
@yusuke.accept_request(@katsu)

@pins.friend_request(@doug)
@pins.friend_request(@yann)
@pins.friend_request(@trouni)
@pins.friend_request(@nicole)
@doug.accept_request(@pins)
@yann.accept_request(@pins)
@trouni.accept_request(@pins)
@nicole.accept_request(@pins)

@katsu.friend_request(@doug)
@katsu.friend_request(@yann)
@doug.accept_request(@katsu)
@yann.accept_request(@katsu)

@yusuke.friend_request(@doug)
@yusuke.friend_request(@yann)
@doug.accept_request(@yusuke)
@yann.accept_request(@yusuke)

@doug.friend_request(@yann)
@yann.accept_request(@doug)

puts "Done creating friendship"

# creating moods

activities = %w[family friends date party netflix reading gaming relax sleep eating exercise walk meditation shopping cleaning cooking laundry work shower alcohol traveling hobbies sick movie TV argument social\ media sex]
random_rating = [0, 1, 2, 3, 4]
bad_rating = [0, 1]
good_rating = [3, 4]
average_rating = [2, 3]

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
puts "Creating good mood for pins"
50.times do
  mood_1 = Mood.new(
    rating: average_rating.sample,
    activity_list: activities.sample,
    created_at: (rand(range)).days.ago
  )
  mood_1.user = @pins
  mood_1.save!
end
puts "Done creating good mood for pins"

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

puts ""
puts "Creating bad mood for today for yusuke"
4.times do
  mood_4 = Mood.new(
    rating: bad_rating.sample,
    activity_list: "work",
    created_at:  Date.today + rand(3..5).hour + rand(0..60).minutes
  )
  mood_4.user = @yusuke
  mood_4.save!
end
puts "Done creating bad mood for today for yusuke"

puts ""
puts "Creating happy mood for today for Katsu"
mood_5 = Mood.new(
  rating: good_rating.sample,
  activity_list: "date",
  created_at:  Date.today + rand(5..6).hour + rand(0..60).minutes
)
mood_5.user = @katsu
mood_5.save!
puts "Done creating happy mood for today for Katsu"

puts ""
puts "Creating mood for today for doug"
4.times do
  mood_6 = Mood.new(
    rating: random_rating.sample,
    activity_list: activities.sample,
    created_at:  Date.today
  )
  mood_6.user = @doug
  mood_6.save!
end
puts "Done creating mood for today for doug"

puts ""
puts "Creating mood for today for yann"
4.times do
  mood_7 = Mood.new(
    rating: random_rating.sample,
    activity_list: activities.sample,
    created_at:  Date.today
  )
  mood_7.user = @yann
  mood_7.save!
end
puts "Done creating mood for today for yann"

puts ""
puts "Creating mood for today for trouni"
4.times do
  mood_8 = Mood.new(
    rating: random_rating.sample,
    activity_list: activities.sample,
    created_at:  Date.today
  )
  mood_8.user = @trouni
  mood_8.save!
end
puts "Done creating mood for today for trouni"

puts ""
puts "Creating mood for today for nicole"
4.times do
  mood_9 = Mood.new(
    rating: random_rating.sample,
    activity_list: activities.sample,
    created_at:  Date.today
  )
  mood_9.user = @nicole
  mood_9.save!
end
puts "Done creating mood for today for nicole"

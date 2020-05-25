# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Clearing database..."
Mood.destroy_all
User.destroy_all

# creating users

puts "Creating pins"
pins = User.create!(
  email: "pins.thoo@gmail.com",
  password: "123456"
)
puts "Done creating pins"

puts ""
puts "Creating katsu"
katsu = User.create!(
  email: "katsu.furugen@gmail.com",
  password: "123456"
)
puts "Done creating katsu"

puts ""
puts "Creating yusuke"
yusuke = User.create!(
  email: "yusuke.ishida@gmail.com",
  password: "123456"
)
puts "Done creating yusuke"

# creating moods

activities = %w[family friends date party netflix reading gaming relax good-sleep bad-sleep eating exercise walk meditation shopping cleaning cooking laundry work shower alcohol traveling]
random_rating = [0, 1, 2, 3, 4]

puts ""
puts "Creating mood for pins"
70.times do
  mood_1 = Mood.new(
    rating: random_rating.sample,
    activity_list: activities.sample,
    created_at: (rand*10).days.ago
  )
  mood_1.user = pins
  mood_1.save!
end
puts "Done creating mood for pins"

puts ""
puts "Creating mood for katsu"
70.times do
  mood_2 = Mood.new(
    rating: random_rating.sample,
    activity_list: activities.sample,
    created_at: (rand*10).days.ago
  )
  mood_2.user = katsu
  mood_2.save!
end
puts "Done creating mood for katsu"

puts ""
puts "Creating mood for yusuke"
70.times do
  mood_3 = Mood.new(
    rating: random_rating.sample,
    activity_list: activities.sample,
    created_at: (rand*10).days.ago
  )
  mood_3.user = yusuke
  mood_3.save!
end
puts "Done creating mood for yusuke"



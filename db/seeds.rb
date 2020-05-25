# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Clearing database..."
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

puts ""
puts "Creating mood for pins"
mood_1 = Mood.new(
  rating: 4,
  activity_list: "eating"
)
mood_1.user = pins
mood_1.save!
puts "Done creating mood for pins"

puts ""
puts "Creating mood for katsu"
mood_2 = Mood.new(
  rating: 3,
  activity_list: "games"
)
mood_2.user = katsu
mood_2.save!
puts "Done creating mood for katsu"

puts ""
puts "Creating mood for yusuke"
mood_3 = Mood.new(
  rating: 4,
  activity_list: "running"
)
mood_3.user = yusuke
mood_3.save!
puts "Done creating mood for yusuke"



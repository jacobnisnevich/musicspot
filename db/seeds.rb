# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Event.create!(
  name: "Concert",
  location: "90024",
  start_datetime: DateTime.new(2016,11,1,15),
  end_datetime: DateTime.new(2016,11,1,16),
  description: "An awesome concert!",
  image: "http://www.clipartbest.com/cliparts/4T9/bKg/4T9bKgLTE.png"
)

99.times do |n|
  name  = "#{Faker::Company.name} Concert"
  location = Faker::Address.zip_code
  description = Faker::Hipster.sentence
  Event.create!(name:  name,
    location: location,
    start_datetime: DateTime.new(2016,11,1,15),
    end_datetime: DateTime.new(2016,11,1,16),
    description: description,
    image: "http://www.clipartbest.com/cliparts/4T9/bKg/4T9bKgLTE.png")
end

puts "Created #{Event.count} events"
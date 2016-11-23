# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

group = Group.create!(
  name: "Awechords",
  location: "90024",
  description: "A co-ed cappella group at UCLA",
  group_type: "Acapella",
  about: "We are a co-ed cappella group at UCLA that strives to share our passion for music with the LA community and empower our members' musicality."
)
event = Event.create!(
  name: "Concert",
  location: "90024",
  start_datetime: DateTime.new(2016,11,1,15),
  end_datetime: DateTime.new(2016,11,1,16),
  description: "An awesome concert!",
  image: "http://www.clipartbest.com/cliparts/4T9/bKg/4T9bKgLTE.png",
)
event.groups << group

99.times do |n|
  name  = Faker::Company.name

  group = Group.create!(
    name: name,
    location: Faker::Address.zip_code,
    description: Faker::Hipster.sentence,
    group_type: Faker::Music.instrument,
    about: Faker::Hipster.paragraph
  )
  event = Event.create!(
    name:  "#{name} Concert",
    location: Faker::Address.zip_code,
    start_datetime: DateTime.new(2016,11,1,15),
    end_datetime: DateTime.new(2016,11,1,16),
    description: Faker::Hipster.sentence,
    image: "http://www.clipartbest.com/cliparts/4T9/bKg/4T9bKgLTE.png"
  )
  event.groups << group
end

puts "Created #{Group.count} events"
puts "Created #{Event.count} events"
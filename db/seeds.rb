# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Event.create!([{
  name: "Band Concert",
  location: "90024",
  start_datetime: DateTime.new(2016,10,30,15),
  end_datetime: DateTime.new(2016,10,30,16),
  description: "An awesome concert."
},
{
  name: "Acapella Concert",
  location: "Santa Monica, California",
  start_datetime: DateTime.new(2016,10,31,16),
  end_datetime: DateTime.new(2016,10,31,17),
  description: "An awesome concert."
},
{
  name: "Gig at Ackerman",
  location: "Ackerman Student Union",
  start_datetime: DateTime.new(2016,11,1,15),
  end_datetime: DateTime.new(2016,11,1,16),
  description: "An awesome gig."
}])

puts "Created #{Event.count} events"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'
require 'json'

url = 'https://randomuser.me/api/?nat=br&results=10'

data = JSON.parse(URI.open(url).read)

User.destroy_all
puts 'seeding...'
data['results'].each_with_index do |random_user, index|
  user = User.create!(
    email: random_user['email'],
    password: 123456,
    phone_number: "+55#{random_user['phone'].split(' ').last}#{rand(9)}",
    country: random_user['location']['country'],
    role: index.even? ? 'doctor' : 'patient',
    city: random_user['location']['city'],
    street: random_user['location']['street']['name'],
    street_number: random_user['location']['street']['number'],
    state: random_user['location']['state'],
    first_name: random_user['name']['first'],
    last_name: random_user['name']['last'],
    image_url: random_user['picture']['large']
    )
  p user
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require 'json'
# require 'open-uri'

url = 'https://api.sputnik8.com/v1/cities/2?api_key=db6584760c51a71d1c5124c95adb9829&username=shliamin@icloud.com'
city_serialized = open(url).read
city = JSON.parse(city_serialized)

puts "Adding new city"
# city["drinks"].each do |item|
# # ingredient['drinks']
# Ingredient.create(name: item["strIngredient1"])
# end

City.create(name: city["name"], photo: city["geo"]["description"]["image"])

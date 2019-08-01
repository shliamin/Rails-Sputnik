# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# require 'json'
# require 'open-uri'


#Необходимо взять массив и для каждого элемента массива получить его id.
#Это будет id каждго конкретного города, которое затем нужно будет с помощью
#интерполяции вставить в url:

#Миграция в базе данных не произойдет, если не очистить ее, так как
#миграция не производится, если уже имеются одинаковые id.

link_to_the_array = 'https://api.sputnik8.com/v1/cities?api_key=db6584760c51a71d1c5124c95adb9829&username=shliamin@icloud.com'
cities_serialized = open(link_to_the_array).read
cities_array = JSON.parse(cities_serialized)

puts "Creating cities database"

cities_array.each do |item|
  url = "https://api.sputnik8.com/v1/cities/#{item["id"]}?api_key=db6584760c51a71d1c5124c95adb9829&username=shliamin@icloud.com"
  city_serialized = open(url).read
  city = JSON.parse(city_serialized)

  City.create(id: item["id"], name: city["name"], photo: city["geo"]["description"]["image"])
end




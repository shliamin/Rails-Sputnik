

require 'json'
require 'open-uri'

# We need to take all the elements ids from array.
# This is the id for each city.
# Then we are using interpolation

# Creating db for all cities:

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

# Creating db for all activities. What is the activity_id?

link_to_all_activities = 'https://api.sputnik8.com/v1/products?api_key=db6584760c51a71d1c5124c95adb9829&username=shliamin@icloud.com'
activities_serialized = open(link_to_all_activities).read
activities_array = JSON.parse(activities_serialized)

puts "Creating activities database"

activities_array.each do |activity_item|
  url_activities = "https://api.sputnik8.com/v1/products/#{activity_item["id"]}?api_key=db6584760c51a71d1c5124c95adb9829&username=shliamin@icloud.com"
  activity_serialized = open(url_activities).read
  activity = JSON.parse(activity_serialized)

# id: activity_item["id"]  or  id: activity["id"]
  Activity.create(id: activity["id"], title: activity["title"], description: activity["description"], photo: activity["cover_photo"]["original"], price: activity["netto_price"], city_id: activity["geo"]["city"]["id"])
end

  # url_activities = "https://api.sputnik8.com/v1/products/23791?api_key=db6584760c51a71d1c5124c95adb9829&username=shliamin@icloud.com"
  # activity_serialized = open(url_activities).read
  # activity = JSON.parse(activity_serialized)



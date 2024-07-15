require 'json'
require 'open-uri'
require 'httparty'
require 'cgi'

PEXELS_API_KEY = ENV['PEXELS_API_KEY']

# Get images from Pexels
def get_photo(query)
  encoded_query = CGI.escape(query)
  url = "https://api.pexels.com/v1/search?query=#{encoded_query}&orientation=landscape&per_page=1"
  response = HTTParty.get(url, headers: { "Authorization" => PEXELS_API_KEY })
  data = JSON.parse(response.body)
  return data["photos"][0]["src"]["large"] if data["photos"] && data["photos"].any?
  nil
end

# Clear existing data
ActivityView.delete_all 
Activity.delete_all 
City.delete_all 

# Downloading JSON file with cities and activities 
file_path = Rails.root.join('db', 'updated_cities_activities.json')
cities_activities = JSON.parse(File.read(file_path))

puts "Creating cities and activities database"

cities_activities.each do |city|
  puts "Creating city: #{city['name']}"
  city_photo = get_photo(city['name'])
  created_city = City.create(id: city['id'], name: city['name'], description: city['description'], photo: city_photo)

  city['activities'].each do |activity|
    puts "Creating activity: #{activity['title']} in #{city['name']}"
    activity_photo = get_photo(activity['title'])
    Activity.create(
      id: activity['id'],
      title: activity['title'],
      description: activity['description'],
      photo: activity_photo,
      price: activity['price'],
      rating: activity['rating'],
      city_id: created_city.id,
      place: activity['place'], 
      theme: activity['theme'], 
      duration: activity['duration'] 
    )
  end
end

puts "Database seeding completed."

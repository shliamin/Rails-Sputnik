
require 'json'
require 'open-uri'
require 'csv'



link_to_the_array = 'https://api.sputnik8.com/v1/cities?api_key=fe8cde00637a56c54f7a991682cac93e&username=efimshliamin@gmail.com'
cities_serialized = open(link_to_the_array).read
cities_array = JSON.parse(cities_serialized)

puts "Creating cities database"

cities_array.each do |item|
  puts "Creating city with item #{item}"
  url = "https://api.sputnik8.com/v1/cities/#{item["id"]}?api_key=fe8cde00637a56c54f7a991682cac93e&username=efimshliamin@gmail.com"
  city_serialized = open(url).read
  city = JSON.parse(city_serialized)

  City.create(id: item["id"], name: city["name"], photo: city["geo"]["description"]["image"])
end




puts "Creating activities database"



  csv_options = { col_sep: ';'}
  filepath = Rails.root.join "app", "csv", "all_views.csv"

  activity_array = []
  CSV.foreach(filepath, csv_options) do |row|

    activity_array << { "view_id" => row[0], "activity_id" => row[2] }

  end

  array_ids = []

  (1..1).each do |i|

    puts "Adding list of ids from page № #{i} from 1"

    link_to_all_activities = "https://api.sputnik8.com/v1/products?api_key=fe8cde00637a56c54f7a991682cac93e&username=efimshliamin@gmail.com&page=#{i}"
    activities_serialized = open(link_to_all_activities).read
    activ_array = JSON.parse(activities_serialized)
    activ_array.each do |activity_item|
      array_ids << activity_item["id"]
    end
  end

  puts "finished"


    array_ids.uniq.each do |activity_id|
      puts "Creating activity with id #{activity_id}"

      url_activities = "https://api.sputnik8.com/v1/products/#{activity_id}?api_key=fe8cde00637a56c54f7a991682cac93e&username=efimshliamin@gmail.com"
      activity_serialized = open(url_activities).read
      activity = JSON.parse(activity_serialized)

        if result = activity_array.find {|h| h["activity_id"].to_i == activity_id}

        Activity.create(id: activity["id"], title: activity["title"], description: activity["description"], photo: activity["cover_photo"]["original"], price: activity["netto_price"], city_id: activity["geo"]["city"]["id"], rating: activity["customers_review_rating"], view_id: result["view_id"].to_i)

      else
        Activity.create(id: activity["id"], title: activity["title"], description: activity["description"], photo: activity["cover_photo"]["original"], price: activity["netto_price"], city_id: activity["geo"]["city"]["id"], rating: activity["customers_review_rating"], view_id: 0)
      end
    end






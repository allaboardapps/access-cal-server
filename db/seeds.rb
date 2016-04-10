puts "BEGIN: Adding Staff and Admin Users"
User.destroy_all

admin_1 = FactoryGirl.create :user, :admin, first_name: "Randy", last_name: "Burgess", email: "wrburgess@gmail.com", password: "EyJDUFqE96UbjesiNKiKm73Lw9mzEa4ja6WF3Xjg9Z7GMPVGvq", password_confirmation: "EyJDUFqE96UbjesiNKiKm73Lw9mzEa4ja6WF3Xjg9Z7GMPVGvq"
admin_2 = FactoryGirl.create :user, :admin
admin_3 = FactoryGirl.create :user, :admin
staff_1 = FactoryGirl.create :user, :staff
staff_2 = FactoryGirl.create :user, :staff
client_basic_1 = FactoryGirl.create :user, :client, :basic
client_basic_2 = FactoryGirl.create :user, :client, :basic
client_basic_3 = FactoryGirl.create :user, :client, :basic
client_pro_1 = FactoryGirl.create :user, :client, :pro
client_pro_2 = FactoryGirl.create :user, :client, :pro
client_pro_3 = FactoryGirl.create :user, :client, :pro
client_premium_1 = FactoryGirl.create :user, :client, :premium
client_premium_2 = FactoryGirl.create :user, :client, :premium
client_premium_3 = FactoryGirl.create :user, :client, :premium
consumer_1 = FactoryGirl.create :user, :consumer
consumer_2 = FactoryGirl.create :user, :consumer
consumer_3 = FactoryGirl.create :user, :consumer
consumer_4 = FactoryGirl.create :user, :consumer
consumer_5 = FactoryGirl.create :user, :consumer
puts "END:   Adding Staff and Admin Users"

puts "BEGIN: Adding Regions and Locations"
Region.destroy_all
Location.destroy_all

region = Region.create name:"Chicago", abbreviation:"CHI"
aville = Location.create name: "Andersonville", abbreviation: "A-ville", region: region
bucktown = Location.create name: "Bucktown", abbreviation: "B-town", region: region
lakeview = Location.create name: "Lakeview", abbreviation: "L-view", region: region
lpark = Location.create name: "Lincoln Park", abbreviation: "L-Park", region: region
region_2 = FactoryGirl.create :region
FactoryGirl.create :location, region: region_2
FactoryGirl.create :location, region: region_2
FactoryGirl.create :location, region: region_2
FactoryGirl.create :location, region: region_2
FactoryGirl.create :location, region: region_2
FactoryGirl.create :location, region: region_2
puts "END:   Adding Regions and Locations"

puts "BEGIN: Adding Events"
Event.destroy_all

[client_basic_1, client_pro_1, client_premium_1, client_basic_2, client_pro_2, client_premium_2].each do |client|
  [aville, bucktown, lakeview, lpark].each do |location|
    FactoryGirl.create :event, author: client, location: location
  end
  [aville, bucktown, lakeview, lpark].each do |location|
    FactoryGirl.create :event, author: client, location: location
  end
  [aville, bucktown, lakeview, lpark].each do |location|
    FactoryGirl.create :event, author: client, location: location
  end
end
puts "END:   Adding Events"

puts "BEGIN: Adding Favorites"
Favorite.destroy_all

[consumer_1, consumer_2, consumer_3, consumer_4, consumer_5].each do |consumer|
  FactoryGirl.create :favorite, user: consumer, event: Event.limit(1).order("RANDOM()").first
  FactoryGirl.create :favorite, user: consumer, event: Event.limit(1).order("RANDOM()").first
  FactoryGirl.create :favorite, user: consumer, event: Event.limit(1).order("RANDOM()").first
  FactoryGirl.create :favorite, user: consumer, event: Event.limit(1).order("RANDOM()").first
  FactoryGirl.create :favorite, user: consumer, event: Event.limit(1).order("RANDOM()").first
end
puts "END:   Adding Favorites"

puts "BEGIN: Adding Tags"
  Rake::Task["app:load_default_tags"].execute
puts "END:   Adding Tags"

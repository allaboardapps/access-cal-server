puts "BEGIN: Adding Staff and Admin Users"
User.destroy_all

admin_1 = FactoryGirl.create :user, :admin, first_name:"Randy",last_name:"Burgess",email:"rb@gmail.com",password:"EyJDUFqE96UbjesiNKiKm73Lw9mzEa4ja6WF3Xjg9Z7GMPVGvq",password_confirmation:"EyJDUFqE96UbjesiNKiKm73Lw9mzEa4ja6WF3Xjg9Z7GMPVGvq"
admin_2 = FactoryGirl.create :user, :admin
admin_3 = FactoryGirl.create :user, :admin
admin_4 = FactoryGirl.create :user, :admin
admin_5 = FactoryGirl.create :user, :admin
customer_1 = FactoryGirl.create :user, :customer
customer_2 = FactoryGirl.create :user, :customer
customer_3 = FactoryGirl.create :user, :customer
customer_4 = FactoryGirl.create :user, :customer
customer_5 = FactoryGirl.create :user, :customer
customer_6 = FactoryGirl.create :user, :customer
customer_7 = FactoryGirl.create :user, :customer
client_1 = FactoryGirl.create :user, :client
client_2 = FactoryGirl.create :user, :client
client_3 = FactoryGirl.create :user, :client
client_4 = FactoryGirl.create :user, :client
client_5 = FactoryGirl.create :user, :client
client_6 = FactoryGirl.create :user, :client
client_7 = FactoryGirl.create :user, :client
client_8 = FactoryGirl.create :user, :client
client_9 = FactoryGirl.create :user, :client
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

[client_1, client_2, client_3, client_4, client_5].each do |client|
  [aville, bucktown, lakeview, lpark].each do |location|
    FactoryGirl.create :event, client: client, location: location
  end
  [aville, bucktown, lakeview, lpark].each do |location|
    FactoryGirl.create :event, client: client, location: location
  end
  [aville, bucktown, lakeview, lpark].each do |location|
    FactoryGirl.create :event, client: client, location: location
  end
end
puts "END:   Adding Events"

puts "BEGIN: Adding Favorites"
Favorite.destroy_all

[customer_1, customer_2, customer_3, customer_4, customer_5].each do |customer|
  FactoryGirl.create :favorite, user: customer, event: Event.limit(1).order("RANDOM()").first
  FactoryGirl.create :favorite, user: customer, event: Event.limit(1).order("RANDOM()").first
  FactoryGirl.create :favorite, user: customer, event: Event.limit(1).order("RANDOM()").first
  FactoryGirl.create :favorite, user: customer, event: Event.limit(1).order("RANDOM()").first
  FactoryGirl.create :favorite, user: customer, event: Event.limit(1).order("RANDOM()").first
end
puts "END:   Adding Favorites"

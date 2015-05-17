puts "BEGIN: Adding Staff and Admin Users"
User.create([
  {first_name:"Randy",last_name:"Burgess",email:"wrburgess@gmail.com",roles:[Roles::ADMIN],password:"EyJDUFqE96UbjesiNKiKm73Lw9mzEa4ja6WF3Xjg9Z7GMPVGvq",password_confirmation:"EyJDUFqE96UbjesiNKiKm73Lw9mzEa4ja6WF3Xjg9Z7GMPVGvq" },
])
FactoryGirl.create :user, :admin
FactoryGirl.create :user, :admin
FactoryGirl.create :user, :admin
FactoryGirl.create :user, :admin
FactoryGirl.create :user, :customer
FactoryGirl.create :user, :customer
FactoryGirl.create :user, :customer
FactoryGirl.create :user, :customer
FactoryGirl.create :user, :customer
FactoryGirl.create :user, :customer
FactoryGirl.create :user, :customer
FactoryGirl.create :user, :client
FactoryGirl.create :user, :client
FactoryGirl.create :user, :client
FactoryGirl.create :user, :client
FactoryGirl.create :user, :client
FactoryGirl.create :user, :client
FactoryGirl.create :user, :client
FactoryGirl.create :user, :client
FactoryGirl.create :user, :client
puts "END:   Adding Staff and Admin Users"

puts "BEGIN: Adding Regions and Locations"
region = Region.create name:"Chicago", abbreviation:"CHI"
location = Location.create name: "Andersonville", abbreviation: "A-ville", region: region
location = Location.create name: "Bucktown", abbreviation: "B-town", region: region
location = Location.create name: "Lakeview", abbreviation: "L-view", region: region
location = Location.create name: "Lincoln Park", abbreviation: "L-Park", region: region
region_2 = FactoryGirl.create :region
FactoryGirl.create :location, region: region_2
FactoryGirl.create :location, region: region_2
FactoryGirl.create :location, region: region_2
FactoryGirl.create :location, region: region_2
FactoryGirl.create :location, region: region_2
FactoryGirl.create :location, region: region_2
puts "END:   Adding Regions and Locations"

FactoryGirl.define do
  factory :event do
    user
    location
    name { Faker::Name.first_name }
    abbreviation { Faker::Name.last_name }
    admin_notes { Faker::Lorem.sentences(1) }
    archived { false }
    test { false }
    street_address { Faker::Address.street_address }
    secondary_address { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip_code { Faker::Address.zip_code }
    country { "USA" }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    starts_at { Time.now }
    ends_at { Time.now + 1.hour }
    timezone { Faker::Address.time_zone }
  end
end

FactoryGirl.define do
  starts_at = Faker::Time.forward(21)

  factory :event do
    author
    location
    name { Faker::Company.catch_phrase }
    abbreviation { Faker::Company.name }
    primary_category { Categories.all.sample }
    categories { [Categories.all.sample(2)] }
    description { Faker::Lorem.sentences(1)[0] }
    admin_notes { Faker::Lorem.sentences(1)[0] }
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
    starts_at { starts_at }
    ends_at { starts_at + 2.hours  }
    time_zone { Faker::Address.time_zone }
  end
end

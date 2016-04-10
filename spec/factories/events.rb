FactoryGirl.define do
  starts_at = Faker::Time.forward(21)

  factory :event do
    author
    location
    calendar
    name { Faker::Company.catch_phrase }
    abbreviation { Faker::Hipster.words(2) }
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
    ends_at { starts_at + [1, 2, 3].sample.hours }
    time_zone { AllowedTimeZones.all.sample }

    trait :archived do
      archived { true }
    end

    trait :test do
      test { true }
    end

    trait :dummy do
      dummy { true }
    end
  end
end

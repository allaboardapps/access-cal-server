FactoryGirl.define do
  factory :region do
    name { Faker::Address.city }
    abbreviation { Faker::Address.city }
    time_zone { AllowedTimeZones.all.sample }
    admin_notes { Faker::Lorem.sentences(1) }
    archived { false }
    test { false }

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

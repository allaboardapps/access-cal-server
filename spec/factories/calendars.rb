FactoryGirl.define do
  factory :calendar do
    name { Faker::Superhero.name }
    abbreviation { Faker::Superhero.name }
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

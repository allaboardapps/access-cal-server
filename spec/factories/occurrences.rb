FactoryGirl.define do
  factory :occurrence do
    event
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

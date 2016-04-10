FactoryGirl.define do
  factory :organization do
    name { Faker::Company.name }

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

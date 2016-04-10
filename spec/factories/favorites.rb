FactoryGirl.define do
  factory :favorite do
    user
    event
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

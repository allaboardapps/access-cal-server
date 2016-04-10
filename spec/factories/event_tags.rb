FactoryGirl.define do
  factory :event_tag do
    event
    tag

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

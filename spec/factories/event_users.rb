FactoryGirl.define do
  factory :event_user do
    user
    event
    role { EventRoles::OWNER }

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

FactoryGirl.define do
  factory :calendar_user do
    user
    calendar
    role { CalendarRoles::OWNER }

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

FactoryGirl.define do
  factory :user, aliases: [:admin, :staff, :client, :consumer, :author, :creator] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { "12345678" }
    password_confirmation { "12345678" }
    confirmed_at Time.current
    admin_notes { Faker::Lorem.sentences(1)[0] }
    archived { false }
    test { false }
    location
    zip_code { Faker::Address.zip_code }
    time_zone { AllowedTimeZones.all.sample }
    roles { [UserRoles::CONSUMER] }
    statuses { [UserStatuses::BASIC] }

    trait :admin do
      roles { [UserRoles::ADMIN] }
      statuses { [UserStatuses::NA] }
    end

    trait :staff do
      roles { [UserRoles::STAFF] }
      statuses { [UserStatuses::NA] }
    end

    trait :client do
      roles { [UserRoles::CLIENT] }
      statuses { [UserStatuses::BASIC] }
    end

    trait :consumer do
      roles { [UserRoles::CONSUMER] }
      statuses { [UserStatuses::BASIC] }
    end

    trait :author do
      roles { [UserRoles::CLIENT] }
      statuses { [UserStatuses::BASIC] }
    end

    trait :basic do
      statuses { [UserStatuses::BASIC] }
    end

    trait :pro do
      statuses { [UserStatuses::PRO] }
    end

    trait :premium do
      statuses { [UserStatuses::PREMIUM] }
    end

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

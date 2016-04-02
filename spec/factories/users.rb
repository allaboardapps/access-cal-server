FactoryGirl.define do
  factory :user, aliases: [:admin, :staff, :client, :consumer, :author, :client_basic, :client_pro, :client_premium] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { "12345678" }
    password_confirmation { "12345678" }
    confirmed_at Date.today
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

    trait :client_basic do
      roles { [UserRoles::CLIENT] }
      statuses { [UserStatuses::BASIC] }
    end

    trait :client_pro do
      roles { [UserRoles::CLIENT] }
      statuses { [UserStatuses::PRO] }
    end

    trait :client_premium do
      roles { [UserRoles::CLIENT] }
      statuses { [UserStatuses::PREMIUM] }
    end
  end
end

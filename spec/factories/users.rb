FactoryGirl.define do
  factory :user, aliases: [:admin, :customer, :client, :author, :basic, :pro, :premium] do
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
    time_zone { Faker::Address.time_zone }
    roles { [UserRoles::CUSTOMER] }
    statuses { [Statuses::BASIC] }

    trait :admin do
      roles { [UserRoles::ADMIN] }
    end

    trait :customer do
      roles { [UserRoles::CUSTOMER] }
    end

    trait :client do
      roles { [UserRoles::CLIENT] }
    end

    trait :author do
      roles { [UserRoles::CUSTOMER] }
    end

    trait :basic do
      statuses { [Statuses::BASIC] }
    end

    trait :pro do
      statuses { [Statuses::PRO] }
    end

    trait :premium do
      statuses { [Statuses::PREMIUM] }
    end
  end
end

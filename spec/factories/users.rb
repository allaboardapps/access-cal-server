FactoryGirl.define do
  factory :user, aliases: [:admin, :customer, :client, :basic, :pro, :premium] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { "12345678" }
    password_confirmation { "12345678" }
    confirmed_at Date.today
    admin_notes { Faker::Lorem.sentences(1) }
    archived { false }
    test { false }
    roles { [Roles::CUSTOMER] }
    statuses { [Statuses::BASIC] }

    trait :admin do
      roles { [Roles::ADMIN] }
    end

    trait :customer do
      roles { [Roles::CUSTOMER] }
    end

    trait :client do
      roles { [Roles::CLIENT] }
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

FactoryGirl.define do
  factory :user, aliases: [:admin, :customer, :client] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { "12345678" }
    password_confirmation { "12345678" }
    confirmed_at Date.today
    archived { false }
    test { false }
    roles { [Roles::CUSTOMER] }

    trait :admin do
      roles { [Roles::ADMIN] }
    end

    trait :customer do
      roles { [Roles::CUSTOMER] }
    end

    trait :client do
      roles { [Roles::CLIENT] }
    end
  end
end

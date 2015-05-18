FactoryGirl.define do
  factory :location do
    region
    name { Faker::Address.city }
    abbreviation { Faker::Address.city }
    time_zone { Faker::Address.time_zone }
    admin_notes { Faker::Lorem.sentences(1) }
    archived { false }
    test { false }
  end
end

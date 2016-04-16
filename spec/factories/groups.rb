FactoryGirl.define do
  factory :group do
    name { Faker::Company.name }
    organization
    group_type { GroupTypes.all.sample }

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

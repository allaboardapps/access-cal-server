FactoryGirl.define do
  factory :group_user do
    user
    group
    role { GroupRoles::OWNER }

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

FactoryGirl.define do
  factory :organization_user do
    user
    organization
    role { OrganizationRoles::OWNER }

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

FactoryGirl.define do
  factory :organization_user do
    user
    organization
    role { OrganizationRoles::OWNER }
  end
end

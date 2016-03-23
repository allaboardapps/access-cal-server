FactoryGirl.define do
  factory :group_user do
    user
    group
    role { GroupRoles::OWNER }
  end
end

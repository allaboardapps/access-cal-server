FactoryGirl.define do
  factory :calendar_user do
    user
    calendar
    role { CalendarRoles::OWNER }
  end
end

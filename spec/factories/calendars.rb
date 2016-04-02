FactoryGirl.define do
  factory :calendar do
    name { Faker::Company.name }
    time_zone { AllowedTimeZones.all.sample }
  end
end

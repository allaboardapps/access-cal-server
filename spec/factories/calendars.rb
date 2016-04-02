FactoryGirl.define do
  factory :calendar do
    name { Faker::Superhero.name }
    time_zone { AllowedTimeZones.all.sample }
  end
end

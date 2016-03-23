FactoryGirl.define do
  factory :activity_log do
    creator
    loggable { |l| l.association(:classroom) }
    activity_action_type { ActivityActionTypes::ARCHIVE }
    description { Faker::Lorem.sentence(15) }
  end
end

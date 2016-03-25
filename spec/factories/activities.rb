FactoryGirl.define do
  factory :activity do
    creator
    loggable { |l| l.association(:event) }
    activity_action_type { ActivityActionTypes::ARCHIVE }
  end
end

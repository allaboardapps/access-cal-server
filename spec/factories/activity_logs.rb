FactoryGirl.define do
  factory :activity_log do
    creator
    loggable { |l| l.association(:event) }
    activity_action_type { ActivityActionTypes::ARCHIVE }
  end
end

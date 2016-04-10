FactoryGirl.define do
  factory :activity do
    creator
    loggable { |l| l.association(:event) }
    activity_action_type { ActivityActionTypes::ARCHIVE }

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

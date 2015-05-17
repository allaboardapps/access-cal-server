FactoryGirl.define do
  factory :favorite do
    user
    event
    archived { false }
    test { false }
  end
end

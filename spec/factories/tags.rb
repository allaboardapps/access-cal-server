FactoryGirl.define do
  factory :tag do
    taggable { |l| l.association(:event) }
    name { Faker::Hipster.word(2) }
    description { Faker::Hipster.word(8) }
  end
end

FactoryGirl.define do
  factory :tag do
    name { Faker::Superhero.name }
    description { Faker::Hipster.sentence(8) }
    tag_type { TagTypes.all.sample }
    tag_category { TagCategories.all.sample }
  end
end

FactoryBot.define do
  factory :recording do
    association :studio
    association :band

    kind { :single }
    name { Faker::FunnyName.name }
    quality { rand(40..100) }
    release_at { Faker::Date.forward(5.minutes) }
    sales { 0 }
  end
end

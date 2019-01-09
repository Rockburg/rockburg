FactoryBot.define do
  factory :activity do
    association :band

    starts_at { Time.now.utc }
    ends_at  { Faker::Date.forward(5.minutes) }
  end
end

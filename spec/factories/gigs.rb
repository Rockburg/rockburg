FactoryBot.define do
  factory :gig do
    association :band
    association :venue

    fans_gained { 1 }
    money_made { 1 }
    played_on { Faker::Date.backward(1) }
  end
end

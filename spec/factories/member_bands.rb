FactoryBot.define do
  factory :member_band do
    association :band
    association :member
    association :skill
  end
end

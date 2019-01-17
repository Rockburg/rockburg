# == Schema Information
#
# Table name: activities
#
#  id         :bigint(8)        not null, primary key
#  action     :string
#  ends_at    :datetime
#  starts_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  band_id    :bigint(8)
#
# Indexes
#
#  index_activities_on_band_id  (band_id)
#

FactoryBot.define do
  factory :activity do
    association :band

    action { :practice }
    starts_at { Time.now.utc }
    ends_at  { Faker::Date.forward(5.minutes) }
  end
end

# == Schema Information
#
# Table name: releases
#
#  id         :bigint(8)        not null, primary key
#  kind       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  band_id    :bigint(8)
#
# Indexes
#
#  index_releases_on_band_id  (band_id)
#

FactoryBot.define do
  factory :release do
    association :band

    name { Faker::FunnyName.name }
    kind { :single }
  end
end

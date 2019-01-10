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

class Release < ApplicationRecord
  belongs_to :band
  has_many :streams
  has_and_belongs_to_many :recordings
end

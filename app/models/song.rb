# == Schema Information
#
# Table name: songs
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  quality    :integer          default(0)
#  status     :string           default("writing")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  band_id    :bigint(8)
#
# Indexes
#
#  index_songs_on_band_id  (band_id)
#

class Song < ApplicationRecord
  belongs_to :band
  has_many :recordings

  def full_song
    "#{name} - Quality: #{quality}"
  end
end

# == Schema Information
#
# Table name: recordings
#
#  id         :bigint(8)        not null, primary key
#  quality    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  band_id    :bigint(8)
#  song_id    :bigint(8)
#  studio_id  :bigint(8)
#
# Indexes
#
#  index_recordings_on_band_id    (band_id)
#  index_recordings_on_song_id    (song_id)
#  index_recordings_on_studio_id  (studio_id)
#
# Foreign Keys
#
#  fk_rails_...  (song_id => songs.id)
#

class Recording < ApplicationRecord
  ## -- RELATIONSHIPS
  belongs_to :band
  belongs_to :studio
  belongs_to :song

  has_and_belongs_to_many :releases

  ## — INSTANCE METHODS
  def full_recording
    "#{name} - (#{kind} -- Quality: #{quality})"
  end

end

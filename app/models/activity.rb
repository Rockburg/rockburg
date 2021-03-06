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

class Activity < ApplicationRecord
  belongs_to :band
  belongs_to :financial, optional: true
  has_many :happenings, dependent: :destroy

  def self.current_activity
    where('ends_at > ?', Time.now)
  end

  ACTIVITIES = {
    'practice' => 'Practicing',
    'write_song' => 'Writing a song',
    'gig'=> 'Playing a gig',
    'record_single' => 'Recording a song',
    'release' => 'Releasing music',
    'rest' => 'Resting',
    'daily_update' => 'Daily Update',
    'hired' => 'Hired a member',
    'song_deleted' => 'Deleted a song',
    'recording_deleted' => 'Deleted a recording',
    'fired' => 'Fired a member',
    'formed' => 'Formed the band'
  }.freeze

  PAST_ACTIVITIES = {
    'practice' => 'Practiced',
    'write_song' => 'Wrote a song',
    'gig'=> 'Played a gig',
    'record_single' => 'Recorded a song',
    'release' => 'Released music',
    'rest' => 'Rested',
    'daily_update' => 'Daily Update',
    'hired' => 'Hired a member',
    'song_deleted' => 'Deleted a song',
    'recording_deleted' => 'Deleted a recording',
    'fired' => 'Fired a member',
    'formed' => 'Formed the band'
  }.freeze

  def humanize_action
    ACTIVITIES[action]
  end

  def humanize_past_action
    PAST_ACTIVITIES[action]
  end
end

# == Schema Information
#
# Table name: happenings
#
#  id          :bigint(8)        not null, primary key
#  kind        :string
#  what        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  activity_id :bigint(8)
#  band_id     :bigint(8)
#
# Indexes
#
#  index_happenings_on_activity_id  (activity_id)
#  index_happenings_on_band_id      (band_id)
#
# Foreign Keys
#
#  fk_rails_...  (activity_id => activities.id)
#

class Happening < ApplicationRecord
  belongs_to :band
  belongs_to :activity

  ## -- SCOPES
  scope :recent, ->{ order(created_at: :desc) }
end

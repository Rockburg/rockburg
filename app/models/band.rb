# == Schema Information
#
# Table name: bands
#
#  id         :bigint(8)        not null, primary key
#  buzz       :bigint(8)        default(0)
#  fans       :bigint(8)        default(0)
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  genre_id   :bigint(8)
#  manager_id :bigint(8)
#
# Indexes
#
#  index_bands_on_genre_id    (genre_id)
#  index_bands_on_manager_id  (manager_id)
#
# Foreign Keys
#
#  fk_rails_...  (genre_id => genres.id)
#

class Band < ApplicationRecord
  belongs_to :manager, counter_cache: :bands_count
  belongs_to :genre
  has_many :financials
  has_many :member_bands
  has_many :members, through: :member_bands
  has_many :activities
  has_many :happenings
  has_many :songs
  has_many :gigs
  has_many :recordings

  def to_param
    [id, name.parameterize].join("-")
  end

  def add_member(member, skill: nil)
    skill ||= member.primary_skill
    self.member_bands.create(member: member, skill: skill)
  end

  def overly_fatigued_members?
    members.pluck(:trait_fatigue).any?{|x| x >= 100 }
  end
end

class Band::RecordAlbum < ApplicationService
  include ActionView::Helpers::NumberHelper
  include ApplicationHelper

  expects do
    required(:band).filled
    required(:activity).filled.value(type?: Integer)
    required(:album).filled
  end

  delegate :band, :album, :activity, to: :context

  before do
    context.band = Band.ensure!(band)
    context.album = band.recordings.albums.ensure!(album)
    # context.fail!(message: "Hours must be positive") unless hours.positive?
  end

  def call
    studio = album.studio
    song_avg = album.songs.average(:quality).to_i

    song_mp = 40
    studio_mp = 30
    skill_mp = 20
    creativity_mp = 5
    ego_mp = 5
    member_multiplyer = band.members.count * 100

    total_skills = band.members.sum(:skill_primary_level).to_i
    total_creativity = band.members.sum(:trait_creativity).to_i
    total_ego = band.members.sum(:trait_ego).to_i

    possible_points = (member_multiplyer * skill_mp) +
      (member_multiplyer * creativity_mp) +
      (studio.cost * studio_mp) +
      (song_avg * song_mp)

    quality = 100

    points = (total_skills * skill_mp) +
      (total_creativity * creativity_mp) +
      (studio.cost * studio_mp) +
      (song_avg * song_mp)

    ego_weight = (total_ego * ego_mp).to_f / possible_points.to_f
    total = quality * (points.to_f / possible_points.to_f)
    ego_reduction = total * ego_weight

    recording_quality = (total - ego_reduction).round
    album.update(quality: recording_quality)

    Band::AddFatigue.(band: band, range: 25..75, activity: activity)
    Band::SpendMoney.(band: band, amount: studio.cost)

    band.happenings.create(what: "#{band.name} recorded an album named #{album.name}! It has a quality score of #{album.quality} and cost #{as_game_currency(studio.cost)} to record.", kind: 'record_album', activity_id: activity)
  end
end

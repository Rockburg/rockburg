class Band::RecordSingle < ApplicationService
  include ActionView::Helpers::NumberHelper
  include ApplicationHelper

  expects do
    required(:band).filled
    required(:recording).filled
    required(:activity).filled.value(type?: Integer)
    optional(:hours) # Hours is not used, apparently
  end

  delegate :band, :recording, :hours, :activity, to: :context

  before do
    context.band = Band.ensure!(band)
    context.recording = band.recordings.ensure!(recording)
    # context.fail!(message: "Hours must be positive") unless hours.positive?
  end

  def call
    studio = recording.studio
    song_quality = recording.song.quality.to_i

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
      (Studio.order(:weight).last.weight * studio_mp) +
      (100 * song_mp)

    quality = 100

    points = (total_skills * skill_mp) +
      (total_creativity * creativity_mp) +
      (studio.weight * studio_mp) +
      (song_quality * song_mp)

    ego_weight = (total_ego * ego_mp).to_f / possible_points.to_f
    total = quality * (points.to_f / possible_points.to_f)
    ego_reduction = total * ego_weight

    recording_quality = (total - ego_reduction).round

    recording.update(quality: recording_quality)

    Band::AddFatigue.(band: band, range: 10..25, activity: activity)
    Band::SpendMoney.(band: band, amount: studio.cost)

    band.happenings.create(what: "#{band.name} made a recording of #{recording.song.name}! It has a quality score of #{recording_quality} and cost #{as_game_currency(studio.cost)} to record.", kind: 'record_single', activity_id: activity)
  end
end

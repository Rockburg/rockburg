class Band::WriteSong < ApplicationService
  expects do
    required(:band).filled
    required(:activity).filled.value(type?: Integer)
    required(:hours).filled.value(type?: Integer)
  end

  delegate :band, :hours, :song, :activity, to: :context

  before do
    context.band = Band.ensure!(band)
    context.hours = hours.to_i
    context.fail!(message: "Hours must be postive") unless hours.positive?
  end

  def call
    Band::AddFatigue.(band: band, range: (2*hours)..(5*hours))

    skill_mp = 50
    creativity_mp = 15
    time_mp = 30
    ego_mp = 5
    member_multiplyer = band.members.count * 100

    total_skills = band.members.sum(:skill_primary_level)
    total_creativity = band.members.sum(:trait_creativity)
    total_ego = band.members.sum(:trait_ego)

    possible_points = (member_multiplyer * skill_mp) +
      (member_multiplyer * creativity_mp) +
      (24 * time_mp)

    quality = 100

    points = (total_skills * skill_mp) + (total_creativity * creativity_mp) + (hours * time_mp)

    ego_weight = (total_ego * ego_mp).to_f / 10_000
    total = quality * (points.to_f / possible_points.to_f)
    ego_reduction = total * ego_weight

    song_quality = (total - ego_reduction).round

    context.song = band.songs.create!(name: Generator.song_title, quality: song_quality)
    band.happenings.create(what: "#{band.name} wrote a new song called #{song.name}! It has a quality score of #{song.quality}.", kind: 'wrote_song', activity_id: activity)
  end
end

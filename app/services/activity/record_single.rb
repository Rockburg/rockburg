class Activity::RecordSingle < ApplicationService
  expects do
    required(:band).filled
    required(:studio).filled
    required(:song).filled
    optional(:hours)
  end

  delegate :band, :hours, :studio, :song, to: :context

  before do
    context.band = Band.ensure(band)
    context.hours = (hours || 10).to_i
    context.fail! unless hours.positive?
    context.studio = Studio.ensure(studio)
    context.song = band.songs.ensure(song)
  end

  def call
    start_at = Time.current
    end_at = start_at + hours * ENV["SECONDS_PER_GAME_HOUR"].to_i
    context.activity = Activity.create!(band: band, action: :record_single, starts_at: start_at, ends_at: end_at)

    release_activity = Activity.create!(band: band, action: :release, starts_at: start_at, ends_at: end_at)

    recording = band.recordings.create(studio: studio, song: song)

    release = band.releases.create!(name: song.name, kind: 'single')

    Band::RecordSingleWorker.perform_at(end_at, band.to_global_id, recording.to_global_id, hours, context.activity.id)

    Band::ReleaseWorker.perform_at(end_at+1.second, band.to_global_id, release.to_global_id, release_activity.id)
  end
end

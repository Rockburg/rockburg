class Activity::ReleaseRecording < ApplicationService
  expects do
    required(:band).filled    
    required(:recording_ids).filled
    optional(:hours)
    required(:release_name).filled
    required(:release_kind).filled
  end

  delegate :band, :recordings, :release_name, :release_kind, :hours, to: :context

  before do
    context.band = Band.ensure(band)
    context.recordings = band.recordings.ensure(context.recording_ids)
    context.hours = (hours || 1).to_i
    context.fail! unless hours.positive?
  end

  def call
    start_at = Time.current
    end_at = start_at + hours * ENV["SECONDS_PER_GAME_HOUR"].to_i
    context.activity = Activity.create!(band: band, action: :release, starts_at: start_at, ends_at: end_at)

    Rails.logger.warn("RECORDINGS: #{recordings}")

    release = band.releases.create!(name: release_name, kind: release_kind)

    recordings.each do |recording|
      release.recordings << recording
    end


    Band::ReleaseWorker.perform_at(end_at, band.to_global_id, release.to_global_id, context.activity.id)
  end
end

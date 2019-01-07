class Activity::WriteSong < ApplicationService
  expects do
    required(:band).filled
    required(:hours).filled.value(type?: Integer)
  end

  delegate :band, :hours, to: :context

  before do
    context.band = Band.ensure(band)
    context.fail! unless hours.to_i.positive?
  end

  def call
    start_at = Time.current
    end_at = start_at + hours.to_i * ENV["SECONDS_PER_GAME_HOUR"].to_i
    context.activity = Activity.create!(band: band, action: :write_song, starts_at: start_at, ends_at: end_at)
    Band::WriteSongWorker.perform_at(end_at, band.to_global_id, hours, context.activity.id)
  end
end

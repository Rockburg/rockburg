class Activity::PlayGig < ApplicationService
  expects do
    required(:band).filled
    required(:venue).filled
    required(:hours).filled.value(type?: Integer)
  end

  delegate :band, :venue, :hours, to: :context

  before do
    context.band = Band.ensure(band)
    context.venue = Venue.ensure(venue)
    context.hours = hours.to_i
    context.fail! unless hours.positive?
  end

  def call
    start_at = Time.current
    end_at = start_at + hours * ENV["SECONDS_PER_GAME_HOUR"].to_i
    context.activity = Activity.create!(band: band, action: :gig, starts_at: start_at, ends_at: end_at)
    gig = band.gigs.create!(venue: venue, played_on: Date.today)
    Band::PlayGigWorker.perform_at(end_at, band.to_global_id, gig.to_global_id, hours, context.activity.id)
  end
end

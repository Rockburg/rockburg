class Activity::StartPractice < ApplicationService
  expects do
    required(:band).filled
    required(:hours).filled.value(type?: Integer)
  end

  delegate :band, :hours, to: :context

  before do
    context.band = Band.ensure(band)
    context.fail! unless hours.positive?
  end

  def call
    start_at = Time.current
    end_at = start_at + hours.seconds
    context.activity = Activity.create!(band: band, action: :practice, starts_at: start_at, ends_at: end_at)
    Band::PracticeWorker.perform_at(end_at, band.to_global_id, hours)
  end
end

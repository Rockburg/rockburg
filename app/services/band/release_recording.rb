class Band::ReleaseRecording < ApplicationService
  include ActionView::Helpers::NumberHelper
  include ApplicationHelper

  expects do
    required(:band).filled
    required(:activity).filled.value(type?: Integer)
    required(:recording).filled
  end

  delegate :band, :recording, :activity, to: :context

  before do
    context.band = Band.ensure!(band)
    context.recording = band.recordings.ensure!(recording)
  end

  def call
    recording.transaction do
      recording.release_at = Time.current

      recording.sales = Recording::CalcEarnings.(recording: recording).earnings
      recording.save!

      Band::EarnMoney.(band: band, amount: recording.sales)

      band.happenings.create(what: "You made #{as_game_currency(recording.sales)} from your release of #{recording.name}!", kind: 'release_earned', activity_id: activity)
    end
  end
end

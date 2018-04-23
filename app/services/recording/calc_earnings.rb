class Recording::CalcEarnings < ApplicationService

  expects do
    required(:recording).filled
  end

  delegate :recording, to: :context

  before do
    context.recording = Recording.ensure!(recording)
  end

  def call
    band = recording.band
    days_since_release = (Date.today - recording.release_at.to_date).to_i

    # 1 to 6% dynamic fan decay rate; defaults 1 if sentiment not found
    sentiment = ExternalSentiment.most_recent_from('lastfm')
    recording_fan_decay_rate = ((sentiment.keys.index(band.genre.name) + 1 rescue 1) / 100.0)

    streams = (band.fans + (band.fans * (band.buzz / 100.0))) * (recording.quality / 100.0) -
      (band.fans * (days_since_release * recording_fan_decay_rate))

    context.earnings = (streams * ::STREAMING_RATE)
  end

end

class Recording::CalcEarnings < ApplicationService

  expects do
    required(:release).filled
  end

  delegate :release, to: :context

  before do
    context.release = Release.ensure!(release)
  end

  def call
    band = release.band
    days_since_release = (Date.today - release.created_at.to_date).to_i

    # 1 to 6% dynamic fan decay rate; defaults 1 if sentiment not found
    sentiment = ExternalSentiment.most_recent_from('lastfm')
    release_fan_decay_rate = ((sentiment.keys.index(band.genre.name) + 1 rescue 1) / 100.0)

    average_recording_quality = release.recordings.average(:quality).to_i

    streams = (band.fans + (band.fans * (band.buzz / 100.0))) * (average_recording_quality / 100.0) -
      (band.fans * (days_since_release * release_fan_decay_rate))

    context.earnings = (streams * ::STREAMING_RATE)
    context.streams = streams
  end

end

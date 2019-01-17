class Band::RecordSingleWorker < Band::ActivityWorker
  def perform(band, recording, hours = nil, activity)
    Band::RecordSingle.(band: band, recording: recording, hours: hours, activity: activity)

    band = Band.ensure(band)
    activity = Activity.ensure(activity)

    announce_completion band, activity
  end
end

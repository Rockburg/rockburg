class Band::ReleaseWorker < Band::ActivityWorker
  def perform(band, release, activity)
    happening = Band::ReleaseRecording.(band: band, release: release, activity: activity)

    band = Band.ensure(band)
    activity = Activity.ensure(activity)

    announce_completion band, activity
  end
end

class Band::WriteSongWorker < Band::ActivityWorker
  def perform(band, hours, activity)
    Band::WriteSong.(band: band, hours: hours, activity: activity)

    band = Band.ensure(band)
    activity = Activity.ensure(activity)

    announce_completion band, activity
  end
end

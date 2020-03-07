class Band::PracticeWorker < Band::ActivityWorker
  def perform(band, hours, activity)
    Band::Practice.(band: band, hours: hours, activity: activity)

    band = Band.ensure(band)
    activity = Activity.ensure(activity)

    announce_completion band, activity
  end
end

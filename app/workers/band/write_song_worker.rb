class Band::WriteSongWorker < Band::ActivityWorker
  def perform(band, hours, activity)
    Band::WriteSong.(band: band, hours: hours, activity: activity)

    band = Band.ensure(band)
    activity = Activity.ensure(activity)

    announce_completion band, activity

    band.manager.add_badge(5) unless band.manager.badges.collect(&:id).include?(5)
  end
end

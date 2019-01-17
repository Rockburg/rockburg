class Band::PracticeWorker < Band::ActivityWorker
  def perform(band, hours, activity)
    Band::Practice.(band: band, hours: hours, activity: activity)

    band = Band.ensure(band)
    activity = Activity.ensure(activity)

    announce_completion band, activity

    band.manager.add_badge(4) unless band.manager.badges.collect(&:id).include?(4)
  end
end

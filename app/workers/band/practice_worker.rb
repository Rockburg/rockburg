class Band::PracticeWorker < ApplicationWorker
  def perform(band, hours, activity)
    Band::Practice.(band: band, hours: hours, activity: activity)
    band = Band.ensure(band)

    ActionCable.server.broadcast "activity_notifications:#{band.manager_id}",
      band: band.id,
      message: "<i class='fa fa-check-circle'></i> Activity done!</div>"

    band.manager.add_badge(4) unless band.manager.badges.collect(&:id).include?(4)
  end
end

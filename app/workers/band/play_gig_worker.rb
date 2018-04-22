class Band::PlayGigWorker < ApplicationWorker
  def perform(band, gig, hours)
    Band::PlayGig.(band: band, gig: gig, hours: hours)

    band = Band.ensure(band)

    ActionCable.server.broadcast "activity_notifications:#{band.manager_id}",
      band: band.id,
      band_fans: band.fans,
      band_buzz: band.buzz,
      message: "<i class='fa fa-check-circle'></i> Activity done!</div>"

    band.manager.add_badge(6) unless band.manager.badges.collect(&:id).include?(6)
  end
end

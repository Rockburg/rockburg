class Band::PlayGigWorker < Band::ActivityWorker
  include ApplicationHelper

  def perform(band, gig, hours, activity)
    Band::PlayGig.(band: band, gig: gig, hours: hours, activity: activity)

    band = Band.ensure(band)
    activity = Activity.ensure(activity)

    announce_completion band, activity,
      band_fans: band.fans,
      band_buzz: band.buzz,
      balance: "#{as_game_currency(band.manager.balance)}"

    band.manager.add_badge(6) unless band.manager.badges.collect(&:id).include?(6)
  end
end

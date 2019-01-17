class Band::ActivityWorker < ApplicationWorker
  def announce_completion(band, activity, options = {})
    ActionCable.server.broadcast "activity_notifications:#{band.manager_id}",
      options.merge({
        band: band.id,
        message: "<i class='fa fa-check-circle'></i> Activity done!</div>"
      })

    ManagerMailer.with(
      user: band.manager,
      band: band,
      activity: activity
    ).activity_completed
     .deliver_later
  end
end

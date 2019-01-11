class Band::ReleaseWorker < ApplicationWorker
  def perform(band, release, activity)
    Band::ReleaseRecording.(band: band, release: release, activity: activity)
    band = Band.ensure(band)

    ActionCable.server.broadcast "activity_notifications:#{band.manager_id}",
      band: band.id,
      message: "<i class='fa fa-check-circle'></i> Activity done!</div>"
  end
end

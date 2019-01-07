class Band::RecordAlbumWorker < ApplicationWorker
  def perform(band, album, activity)
    Band::RecordAlbum.(band: band, album: album, activity: activity)
    band = Band.ensure(band)

    ActionCable.server.broadcast "activity_notifications:#{band.manager_id}",
      band: band.id,
      message: "<i class='fa fa-check-circle'></i> Activity done!</div>"
  end
end

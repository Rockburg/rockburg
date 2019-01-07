class Band::RecordSingleWorker < ApplicationWorker
  def perform(band, recording, hours = nil, activity)
    Band::RecordSingle.(band: band, recording: recording, hours: hours, activity: activity)
    band = Band.ensure(band)

    ActionCable.server.broadcast "activity_notifications:#{band.manager_id}",
      band: band.id,
      message: "<i class='fa fa-check-circle'></i> Activity done!</div>"
  end
end

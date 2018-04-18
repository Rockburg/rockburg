class Band::RestWorker < ApplicationWorker
  def perform(band, hours)
    Band::RemoveFatigue.(band: band, hours: hours)
    manager = GlobalID::Locator.locate(band).manager
    band_id = GlobalID::Locator.locate(band).id

    ActionCable.server.broadcast "activity_notifications:#{manager.id}", band:band_id, message:"<i class='fa fa-check-circle'></i> Activity done!</div>"
  end
end

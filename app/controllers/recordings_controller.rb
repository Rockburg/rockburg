class RecordingsController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_band, only: [:destroy]
  before_action :set_recording, only: [:destroy]

  def index
  end

  def destroy
    if @recording.destroy

      activity = Activity.create!(band: @band, action: :recording_deleted, starts_at: Time.now, ends_at: Time.now)

      @band.happenings.create(what: "#{@recording.name} was thrown in the trash!", kind: 'trash', activity_id: activity.id)
      redirect_to band_path(@band), alert: "#{@recording.name} was deleted."
    else
      redirect_to root_path, alert: 'Something went wrong.'
    end
  end

  private

  def set_band
    @band = current_manager.bands.find(params[:band_id]) rescue nil
    redirect_to root_path, alert: "You can't do that." if @band.nil?
  end

  def set_recording
    @recording = @band.recordings.find(params[:id]) rescue nil
    redirect_to root_path, alert: "You can't do that." if @recording.nil?
  end
end

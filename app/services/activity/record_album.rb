class Activity::RecordAlbum < ApplicationService
  expects do
    required(:band).filled
    required(:studio).filled
    required(:recording_ids).filled
    optional(:hours)
    optional(:album_name)
  end

  delegate :band, :hours, :studio, :recordings, :album_name, to: :context

  before do
    context.band = Band.ensure(band)
    context.hours = (hours || 60).to_i
    context.fail! unless hours.positive?
    context.studio = Studio.ensure(studio)
    context.recordings = band.recordings.ensure(context.recording_ids)
  end

  def call
    start_at = Time.current
    end_at = start_at + hours * ENV["SECONDS_PER_GAME_HOUR"].to_i
    context.activity = Activity.create!(band: band, action: :record_album, starts_at: start_at, ends_at: end_at)

    studio_name = studio.name.sub(" Recording Studio",'').sub(' Studios','').sub(' Studio','')
    album_bame = album_name || "#{studio.name} - #{Generator.album_name}"
    album = band.recordings.create!(studio: studio, kind: :album, name: album_name)

    recordings.each do |recording|
      album.singles << recording
    end

    Band::RecordAlbumWorker.perform_at(end_at, band.to_global_id, album.to_global_id, context.activity.id)
  end
end

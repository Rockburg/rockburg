class ActivitiesController < ApplicationController
  def new
    band = Band.ensure!(params[:band_id])
    context = nil

    if band.overly_fatigued_members? and params[:type] != 'rest'
      skip_authorization
      redirect_to band_path(band), notice: "Your band is too tired!"
      return
    end

    case params[:type]
    when 'practice'
      context = Activity::Practice.call(
        band: params[:band_id],
        hours: params[:hours].to_i
      )

    when 'write_song'
      context = Activity::WriteSong.call(
        band: params[:band_id],
        hours: params[:hours].to_i
      )

    when 'gig'
      context = Activity::PlayGig.call(
        band: params[:band_id],
        venue: params[:venue],
        hours: 120
      )

    when 'record_single'
      context = Activity::RecordSingle.call(
        band: params[:band_id],
        studio: params[:studio][:studio_id],
        song: params[:song_id]
      )

    when 'release'
      context = Activity::ReleaseRecording.call(
        band: params[:band_id],
        release_name: params[:release][:name],
        release_kind: params[:release][:kind],
        recording_ids: params[:recording_ids],
        hours: 1
      )

    when 'rest'
      context = Activity::Rest.call(
        band: params[:band_id],
        hours: params[:hours].to_i
      )
    else
      raise ArgumentError.new("Unknown Type[#{params[:type]}]")
    end

    if context && context.success?
      authorize(context.activity, "#{params[:type]}?")

      if context.activity.save
        redirect_to band_path(band)
        return
      end
    else
      skip_authorization
    end

    head :unprocessable_entity
  end
end

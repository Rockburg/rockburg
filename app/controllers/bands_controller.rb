class BandsController < ApplicationController
  layout false, only: [:happenings, :allmembers]
  skip_after_action :verify_authorized, only: %i[happenings allmembers]
  after_action :verify_policy_scoped, only: %i[index happenings allmembers]

  def index
    not_implemented
  end

  def new
    @band = Band.new(manager: current_manager)
    authorize(@band)
  end

  def create
    @band = Band.new(band_params)
    @band.manager = current_manager
    authorize(@band)
    if @band.save

      activity = Activity.create!(band: @band, action: :formed, starts_at: Time.now, ends_at: Time.now)

      @band.happenings.create(what: "#{@band.name} has just been formed!", kind: 'new', activity_id: activity.id)
      redirect_to @band, alert: "Band created successfully."
    else
      redirect_to new_band_path, alert: "Error creating band."
    end
  end

  def edit
  end

  def update
  end

  def show
    @band = policy_scope(Band).where(id: params[:id]).first
    authorize(@band)
    if !@band
      redirect_to dashboard_path
      return
    end
    @activity = @band.activities.current_activity.try(:last)
  end

  def happenings
    @band = policy_scope(Band).find_by(id: params[:id])
  end

  def allmembers
    @band = policy_scope(Band).find_by(id: params[:id])
  end

  private

  def band_params
    params.require(:band).permit(:name, :genre_id)
  end
end

class MembersController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_member, only: [:destroy]
  before_action :set_band, only: [:destroy]
  skip_after_action :verify_authorized, only: :hire
  layout false, only: [:show]

  def index
    not_implemented
  end

  def show
    @member = policy_scope(Member).find_by_id(params[:id])
  end

  def new
    not_implemented
  end

  def edit
    not_implemented
  end

  # idea - conform hire to 'create' convention
  def hire
    result = Band::HireMember.(band: params[:band_id], skill: params[:skill_id], member: params[:id])
    if result.success?
      redirect_to band_path(params[:band_id]), alert: "Member hired successfully."
    else
      redirect_to new_band_path, alert: result.message || "Error hiring member."
    end
  end

  def destroy
    authorize(@member_band)
    if @member_band.destroy
      activity = Activity.create!(band: @band, action: :fired, starts_at: Time.now, ends_at: Time.now)

      @band.happenings.create(what: "#{@member_band.member.name} was fired!", kind: 'fired', activity_id: activity.id)
      redirect_to band_path(@band), alert: "#{@member_band.member.name} was fired."
    else
      redirect_to root_path, alert: 'Something went wrong.'
    end
  end

  private

  def set_member
    @member_band = current_manager.member_bands.find_by(member_id: params[:member_id])
    redirect_to root_path, alert: "You can't do that." if @member_band.nil?
  end

  def set_band
    @band = current_manager.bands.find(params[:band_id]) rescue nil
    redirect_to root_path, alert: "You can't do that." if @band.nil?
  end

end

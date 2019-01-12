class ManagersController < ApplicationController
  before_action :authenticate_manager!, except: [:show]

  def index
    @manager = current_manager
    @bands = current_manager.bands.all
    @badges = current_manager.badges
    render(:action => 'show')
  end

  def show
    @manager = Manager.find(params[:id])
    @bands = @manager.bands.all
    @badges = @manager.badges
  end

  def edit
    @manager = current_manager
  end

  def file_bankruptcy
    if current_manager.bankrupt? and current_manager.file_bankruptcy
      redirect_to dashboard_path, alert: "You've filed for bankruptcy. Better luck this time around!"
    elsif
      redirect_to dashboard_path
    end
  end
end

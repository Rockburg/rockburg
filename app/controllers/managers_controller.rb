class ManagersController < ApplicationController
  before_action :authenticate_manager!, except: [:show]

  def index
    @manager = authorize(current_manager)
    @bands = policy_scope(Band).all
    @badges = current_manager.badges
    render(:action => 'show')
  end

  def show
    @manager = authorize(policy_scope(Manager).find(params[:id]))
    @bands = @manager.bands.all
    @badges = @manager.badges
  end

  def edit
    @manager = authorize(current_manager)
  end

  def file_bankruptcy
    authorize(current_manager)
    if current_manager.bankrupt? and current_manager.file_bankruptcy
      redirect_to dashboard_path, alert: "You've filed for bankruptcy. Better luck this time around!"
    elsif
      redirect_to dashboard_path
    end
  end
end

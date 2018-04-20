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
end

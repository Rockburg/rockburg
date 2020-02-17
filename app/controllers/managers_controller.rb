class ManagersController < ApplicationController
  before_action :require_user!, except: [:new, :show, :create]

  def index
    @manager = current_manager
    @bands = policy_scope(Band).where(manager_id: current_manager.id).all.order(:name)

    render(:action => 'show')
  end

  def new
    @manager = Manager.new
  end

  def create
    @manager = Manager.new manager_params
  
    if @manager.save
      sign_in @manager
      redirect_to @manager, flash: { notice: 'Welcome!' }
    else
      render :new
    end
  end

  def show
    @manager = authorize(policy_scope(Manager).find(params[:id]))
    @bands = @manager.bands.all
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

  private

  def manager_params
    params.require(:manager).permit(:email)
  end
end

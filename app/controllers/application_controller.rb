class ApplicationController < ActionController::Base
  include Passwordless::ControllerHelpers
  include Pundit
  protect_from_forgery with: :exception
  #before_action :configure_permitted_parameters, if: :devise_controller?
  #before_action :set_last_seen_at, if: proc { manager_signed_in? }
  #after_action :verify_authorized, except: :index, unless: :devise_controller?
  #after_action :verify_policy_scoped, only: :index, unless: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper_method :current_user, :current_manager

  def current_user
    current_manager
  end

  def current_manager
    @current_manager ||= authenticate_by_session(Manager)
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  protected

  def not_implemented
    raise ActionController::RoutingError.new('Not Implemented')
  end

  private

  def require_user!
    return if current_user
    redirect_to root_path, flash: { error: 'You are not worthy!' }
  end

  def user_not_authorized
    flash[:alert] = "Woah! It looks like you can't do this."
    redirect_to(request.referrer || root_path)
  end
end

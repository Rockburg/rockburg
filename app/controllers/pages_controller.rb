class PagesController < ApplicationController
  def index
    skip_policy_scope
    
    redirect_to dashboard_path if current_manager
  end
end

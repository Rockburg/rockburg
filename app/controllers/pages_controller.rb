class PagesController < ApplicationController
  def index
    skip_policy_scope
    # code
  end
end

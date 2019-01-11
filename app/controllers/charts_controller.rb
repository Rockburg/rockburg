class ChartsController < ApplicationController
  skip_after_action :verify_authorized
  after_action :verify_policy_scoped

  def index
    @managers = policy_scope(Manager).with_bands.order(balance: :desc).limit(5)
    @bands = policy_scope(Band).order(buzz: :desc).joins(:manager).limit(5)
    @releases = policy_scope(Recording).released.order(sales: :desc).limit(5)
  end

  def bands
    @bands = policy_scope(Band).order(buzz: :desc).limit(30)
  end

  def managers
    @managers = policy_scope(Manager).with_bands.order(balance: :desc).limit(30)
  end

  def releases
    skip_policy_scope
    #@releases = Release.join(:streams).order(num_streams: :desc).limit(30)
  end
end

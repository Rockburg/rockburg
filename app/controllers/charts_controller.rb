class ChartsController < ApplicationController
  def index
    @managers = Manager.with_bands.order(balance: :desc).limit(5)
    @bands = Band.order(buzz: :desc).joins(:manager).limit(5)
    @releases = Release.joins(:streams).order(num_streams: :desc).limit(5)
  end

  def bands
    @bands = Band.order(buzz: :desc).limit(30)
  end

  def managers
    @managers = Manager.with_bands.order(balance: :desc).limit(30)
  end

  def releases
    #@releases = Release.join(:streams).order(num_streams: :desc).limit(30)
  end
end

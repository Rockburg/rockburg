class ChartsController < ApplicationController
  def index
    @managers = Manager.with_bands.order(balance: :desc).limit(5)
    @bands = Band.order(buzz: :desc).joins(:manager).limit(5)
    @releases = Recording.released.order(sales: :desc).limit(5)
  end

  def bands
    @bands = Band.order(buzz: :desc).limit(30)
  end

  def managers
    @managers = Manager.with_bands.order(balance: :desc).limit(30)
  end

  def releases
    @releases = Recording.released.order(sales: :desc).limit(30)
  end
end
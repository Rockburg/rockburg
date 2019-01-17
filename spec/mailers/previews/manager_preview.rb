# Preview all emails at http://localhost:3000/rails/mailers/manager
class ManagerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/manager/balance_getting_low
  def balance_getting_low
    ManagerMailer.with(user: Manager.where("balance > 0 and balance < 250").first).balance_getting_low
  end

  # Preview this email at http://localhost:3000/rails/mailers/manager/balance_negative
  def balance_negative
    ManagerMailer.with(user: Manager.where("balance < 0").first).balance_negative
  end

  # Preview this email at http://localhost:3000/rails/mailers/manager/activity_completed
  def activity_completed
    happening = Happening.joins(:band, :activity).order("RANDOM()").first
    activity = happening.activity
    band = happening.band
    manager = band.manager

    ManagerMailer.with(
      user: manager,
      band: band,
      activity: activity
    ).activity_completed
  end
end

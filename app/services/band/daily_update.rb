class Band::DailyUpdate < ApplicationService
  include ApplicationHelper
  expects do
    required(:band).filled
  end

  delegate :band, to: :context

  before do
    context.band = Band.ensure(band)
  end

  def call
    activity = Activity.create!(band: band, action: :daily_update, starts_at: Time.now, ends_at: Time.now)

    calc_daily_running_costs(band, activity.id)
    calc_release_earnings(band, activity.id)
    decay_buzz(band, activity.id)
    decay_fans(band, activity.id)
  end

  def calc_daily_running_costs(band, activity_id)
    # Daily running costs
    daily_running_costs = band.members.map(&:cost_generator).sum

    # Rest
    Band::RemoveFatigue.(band: band, hours: 8)

    band.happenings.create(what: "#{band.name} spent #{as_game_currency(daily_running_costs)} on daily running costs.", kind: 'spent', activity_id: activity_id)

    context.daily_running_costs = daily_running_costs
  end

  def calc_release_earnings(band, activity_id)
    # Release earnings
    band.recordings.released.each do |recording|
      earnings = Recording::CalcEarnings.(recording: recording).earnings

      context.earnings = earnings
      recording.increment!(:sales, earnings)
      band.happenings.create(what: "#{band.name} made #{as_game_currency(earnings)} from streams of #{recording.name}.", kind: 'earned', activity_id: activity_id)
    end
  end

  def decay_buzz(band, activity_id)
    # Decay buzz
    previous_buzz = band.buzz
    decayed_buzz = (band.buzz * BAND_BUZZ_DECAY).ceil
    decayed_amount = previous_buzz - decayed_buzz

    band.update_attributes(buzz: decayed_buzz)
    band.happenings.create(what: "#{band.name}'s buzz decreased by #{decayed_amount} to #{decayed_buzz}.", kind: 'buzz_decay', activity_id: activity_id)
  end

  def decay_fans(band, activity_id)
    # Decay fans based on external popularity of band's genre

    # 0 to ~15% dynamic decay rate; defaults 0 if sentiment not found
    sentiment = ExternalSentiment.most_recent_from('lastfm')
    impact = ((sentiment.keys.index(band.genre.name) / 3.25) / 10.0) rescue 0

    previous_fans = band.fans
    decayed_fans = (band.fans * (0.95 - impact)).ceil # guarantees minimum 5% daily decay + external impact

    decayed_amount = previous_fans - decayed_fans
    
    band.update_attributes(fans: decayed_fans)
    band.happenings.create(what: "#{band.name}'s fans decreased by #{decayed_amount} to #{decayed_fans}.", kind: 'fan_decay', activity_id: activity_id)
  end
end

class Band::DailyUpdate < ApplicationService
  expects do
    required(:band).filled
  end

  delegate :band, to: :context

  before do
    context.band = Band.ensure(band)
  end

  def call
    calc_daily_running_costs(band)
    calc_release_earnings(band)
    decay_buzz(band)
    decay_fans(band)
  end

  def calc_daily_running_costs(band)
    # Daily running costs
    daily_running_costs = band.members.map(&:cost_generator).sum

    # Rest
    Band::RemoveFatigue.(band: band, hours: 8)

    band.happenings.create(what: "#{band.name} spent §#{daily_running_costs} on daily running costs.", kind: 'spent')

    context.daily_running_costs = daily_running_costs
  end

  def calc_release_earnings(band)
    # Release earnings
    band.recordings.released.each do |recording|
      earnings = Recording::CalcEarnings.(recording: recording).earnings

      context.earnings = earnings
      recording.increment!(:sales, earnings)
      band.happenings.create(what: "#{band.name} made #{to_game_currency(earnings)} from streams of #{recording.name}.", kind: 'earned')
    end
  end

  def decay_buzz(band)
    # Decay buzz
    decayed_buzz = (band.buzz * BAND_BUZZ_DECAY).ceil
    band.update_attributes(buzz: decayed_buzz)
    band.happenings.create(what: "#{band.name}'s buzz decreased to #{decayed_buzz}.", kind: 'buzz_decay')
  end

  def decay_fans(band)
    # Decay fans
    decayed_fans = (band.fans * BAND_FAN_DECAY).ceil
    band.update_attributes(fans: decayed_fans)
    band.happenings.create(what: "#{band.name}'s fans decreased to #{decayed_fans}.", kind: 'fan_decay')
  end
end

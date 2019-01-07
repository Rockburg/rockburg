class Band::PlayGig < ApplicationService
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TextHelper

  expects do
    required(:band).filled
    required(:gig).filled
    required(:activity).filled.value(type?: Integer)
    required(:hours).filled.value(type?: Integer)
  end

  delegate :band, :gig, :hours, :activity, to: :context

  before do
    context.band = Band.ensure(band)
    context.gig = band.gigs.ensure!(gig)
    context.fail!(message: "Hours must be positive") unless hours.positive?
  end

  def call
    cap = gig.venue.capacity.to_f
    buzz = band.buzz.to_f
    fans = band.fans.to_f

    # 0 to ~5 additional buzz pending genre popularity; defaults 0
    sentiment = ExternalSentiment.most_recent_from('lastfm')
    buzz += sentiment.keys.reverse.index(band.genre.name) rescue 0

    attendance = ((((fans/cap)**rand(1.1..1.7)) * 100) + (fans * (buzz / 1000))).ceil
    attendance = attendance.zero? ? rand(1..5) : attendance
    attendance = [attendance, cap].min

    new_fan_percent = ((attendance/cap)**rand(1..3.5)) * rand(0.2..0.45)
    new_fans = (attendance * new_fan_percent).ceil
    new_fans = new_fans.zero? ? rand(1..4) : new_fans
    new_fans = [new_fans, cap].min

    new_buzz = (((attendance / cap)**rand(1..2.5)) * 100).ceil
    new_buzz = new_buzz.zero? ? rand(1..3) : new_buzz

    ticket_price = 10.0
    revenue = attendance * ticket_price

    band.transaction do
      Band::AddFatigue.(band: band, range: 5..15)

      band.increment!(:fans, new_fans.to_i)
      band.increment!(:buzz, new_buzz.to_i)
      Band::EarnMoney.(amount: revenue, band: band)

      gig.update_attributes(fans_gained: new_fans, money_made: revenue)

      band.happenings.create(what: "You made §#{number_with_delimiter(revenue.to_i)} from #{pluralize(attendance.to_i, "person")} at your gig!", kind: 'earned', activity_id: activity)
      band.happenings.create(what: "You gained #{pluralize(new_fans.to_i, "new fan")} and #{new_buzz} buzz at your gig!", kind: 'earned', activity_id: activity)
    end
  end
end

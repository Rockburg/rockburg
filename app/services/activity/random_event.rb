class Activity::RandomEvent < ApplicationService
  expects do
    required(:band).filled
    required(:activity).filled
    required(:end_at).filled
  end

  delegate :band, :activity, :end_at, to: :context

  before do
    context.band = Band.ensure(band)
    context.activity = activity
    context.end_at = end_at
    #context.fail! unless hours.positive?
  end

  def call
    random_gen = rand
    case context.activity
    when 'gig'
      # Van breaks down on the way to a gig
      if random_gen <= 0.03
        Band::RandomEventWorker.perform_at(end_at, band.to_global_id)
        cost_to_fix = rand(250..500).round(-1)
        band.happenings.create(what: "Your van broke down on the way to the gig! It cost §#{number_with_delimiter(cost_to_fix.to_i)} to fix it!", kind: 'negative', created_at: end_at)
      end
    end
  end
end

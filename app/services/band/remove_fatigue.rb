class Band::RemoveFatigue < ApplicationService
  expects do
    required(:band).filled
    required(:activity).filled.value(type?: Integer)
    required(:hours).filled
  end

  delegate :band, :hours, :activity, to: :context

  before do
    context.band = Band.ensure(band)
    context.hours = hours.to_i
    context.fail!(message: "Hours must be positive") unless hours.positive?
  end

  def call
    range = (20 * hours)..(50 * hours)
    band.members.each do |member|
      member.transaction do
        decrease_fatigue_amount = [(rand(range) / 10.0).ceil, member.trait_fatigue].min
        member.trait_fatigue -= decrease_fatigue_amount
        member.save
        band.happenings.create(what: "#{member.name}'s fatigue decreased by #{decrease_fatigue_amount}", kind: 'fatigue_decrease', activity_id: activity)
      end
    end
  end
end

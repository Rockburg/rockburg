class Band::Practice < ApplicationService
  expects do
    required(:band).filled
    required(:activity).filled.value(type?: Integer)
    required(:hours).filled.value(type?: Integer)
  end

  delegate :band, :hours, :activity, to: :context

  before do
    context.band = Band.ensure(band)
    context.fail!(message: "Hours must be positive") unless hours.positive?
  end

  def call
    band.members.each do |member|
      result = Member::Practice.(member: member, hours: hours)
      if result.success?
        band.happenings.create(what: "#{member.name}'s fatigue increased by #{result.fatigue_change}", kind: 'fatigue_increase', activity_id: activity)
        band.happenings.create(what: "#{member.name}'s skill increased by #{result.skill_change}", kind: 'skill_increase', activity_id: activity)
      end
    end
  end
end

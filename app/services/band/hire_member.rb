class Band::HireMember < ApplicationService

  expects do
    required(:band).filled
    required(:skill).filled
    required(:member).filled
  end

  delegate :band, :skill, :member, to: :context

  before do
    context.band = Band.ensure!(band)
    context.skill = Skill.ensure!(skill)
    context.fail!(message: "Not a skill for this band") unless band.genre.skills.where(id: skill.id).exists?
    context.member = Member.ensure!(member)
  end

  def call
    member_band = MemberBand.create!(band: band, skill: skill, member: member, joined_band_at: Time.current)
    # broadcast(:hire_member, band: band, member: member)
    Band::SpendMoney.(amount: member.cost_generator, band: band)

    activity = Activity.create!(band: band, action: :hired, starts_at: Time.now, ends_at: Time.now)

    band.happenings.create(what: "#{member.name} was hired to #{member.primary_skill.verb} #{member.primary_skill.name}!", kind: 'hired', activity_id: activity.id)
  end
end

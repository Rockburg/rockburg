class Member::Practice < ApplicationService
  # include Wisper::Publisher

  expects do
    required(:member).filled
    required(:hours).filled.value(type?: Integer)
  end

  delegate :member, :hours, to: :context

  before do
    context.member = Member.ensure(member)
    # self.subscribe(Band::Subscriber.new)
  end

  def call
    increase_skill = (rand(1..6) * hours / 10.0).ceil
    increase_fatigue = (rand(1..10) * hours / 5.0).ceil

    Member.transaction do
      if member.trait_fatigue + increase_fatigue > 100
        member.trait_fatigue = 100
      else
        member.trait_fatigue += increase_fatigue
      end


      context.skill_change = increase_skill
      context.fatigue_change = increase_fatigue

      if member.skill_primary_level + increase_skill > 100
        member.skill_primary_level = 100
      else
        member.skill_primary_level += increase_skill
      end

      member.save!

      # broadcast(:stat_change, {stat: :skill_primary_level, member: member.to_global_id, change: increase_skill})
      # broadcast(:stat_change, {stat: :trait_fatigue, member: member.to_global_id, change: increase_fatigue})
    end
  end
end

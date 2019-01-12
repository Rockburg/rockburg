require 'rails_helper'

RSpec.describe Band::AddFatigue, type: :service do
  let(:member1) { create(:member, primary_skill: Skill.find_by_name('Keyboards')) }
  let(:member2) { create(:member, primary_skill: Skill.find_by_name('Drummer')) }
  let(:genre) { Genre.find_by_style('Drum & Bass') }
  let(:band) { create :band, genre: genre }
  let(:activity) { create :activity, band: band }

  it 'should add fatigue to all members' do
    band.add_member(member1, skill: member1.primary_skill)
    band.add_member(member2, skill: member2.primary_skill)

    m1_orig_fatigue = member1.trait_fatigue
    m2_orig_fatigue = member2.trait_fatigue

    result = described_class.call(band: band, range: 10..20, activity: activity)
    expect(result.success?).to eq(true)

    member1.reload
    member2.reload
    expect(member1.trait_fatigue).to be > m1_orig_fatigue
    expect(member2.trait_fatigue).to be > m2_orig_fatigue
  end
end

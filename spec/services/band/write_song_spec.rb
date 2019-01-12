require 'rails_helper'

RSpec.describe Band::WriteSong, type: :service do
  let(:member1) { create(:member, primary_skill: Skill.find_by_name('Keyboards')) }
  let(:member2) { create(:member, primary_skill: Skill.find_by_name('Drummer')) }
  let(:genre) { Genre.find_by_style('Drum & Bass') }
  let(:band) { create :band, genre: genre }

  it 'should create a new song' do
    band.add_member(member1, skill: member1.primary_skill)
    band.add_member(member2, skill: member2.primary_skill)
    song = nil

    expect {
      song = described_class.call(band: band, hours: 6, activity: create(:activity, band: band)).song
    }.to change { band.songs.count }.by(1)

    expect(song.quality).to be_positive
    expect(song.name).not_to be_blank
    expect(song.band).to eq(band)
  end
end

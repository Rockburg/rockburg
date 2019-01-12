require 'rails_helper'

RSpec.describe Activity::ReleaseRecording, type: :service do
  let(:member1) { create(:member, primary_skill: Skill.find_by_name('Keyboards')) }
  let(:member2) { create(:member, primary_skill: Skill.find_by_name('Drummer')) }
  let(:genre) { Genre.find_by_style('Drum & Bass') }
  let(:band) { create :band, genre: genre, fans: 100, buzz: 100 }
  let(:studio) { create :studio, cost: 1000}

  describe "Release ALBUM" do
    require 'sidekiq/testing'
    before do
      band.add_member(member1, skill: member1.primary_skill)
      band.add_member(member2, skill: member2.primary_skill)
      Sidekiq::Testing.inline! do
        3.times do
          song = create :song, band: band
          Activity::RecordSingle.(band: band, studio: studio, song: song)
        end
      end
    end

    it 'should release an album' do
      # balance = band.manager.balance

      Sidekiq::Testing.inline! do
        result = described_class.call(band: band, recording_ids: band.recordings.ids, release_name: Faker::FunnyName.name, release_kind: :album)
        expect(result.success?).to eq(true)
        expect(result.activity).to be_present
      end

      # TODO: Revisit comments in Band::ReleaseRecording
      # expect(album.release_at).not_to be_nil
      # expect(album.sales).to be > sales
      # expect(balance).to be > band.manager.balance
    end
  end

  describe "Release SINGLE" do
    require 'sidekiq/testing'
    before do
      band.add_member(member1, skill: member1.primary_skill)
      band.add_member(member2, skill: member2.primary_skill)
      Sidekiq::Testing.inline! do
        song = create :song, band: band
        Activity::RecordSingle.(band: band, studio: studio, song: song)
      end
    end

    it 'should release a single' do
      # balance = band.manager.balance
      # recording = band.recordings.singles.first
      # expect(recording).not_to be_nil
      # expect(recording.release_at).to be_nil
      # sales = recording.sales

      Sidekiq::Testing.inline! do
        result = described_class.call(band: band, recording_ids: [band.recordings.ids.first], release_name: Faker::FunnyName.name, release_kind: :single)
        expect(result.success?).to eq(true)
        expect(result.activity).to be_present
      end

      # TODO: Revisit comments in Band::ReleaseRecording
      # recording.reload
      # band.manager.reload
      # expect(recording.release_at).not_to be_nil
      # expect(recording.sales).to be > sales
      # expect(balance).to be > band.manager.balance
    end
  end

end

require 'rails_helper'

RSpec.describe Band::WriteSongWorker, type: :worker do
  let(:genre) { Genre.find_by_style('Drum & Bass') }
  let(:band) { create :band, genre: genre }
  let(:member1) { create(:member, primary_skill: Skill.find_by_name('Keyboards')) }
  let(:member2) { create(:member, primary_skill: Skill.find_by_name('Drummer')) }
  let(:hours) { 1 }
  let(:activity) { create :activity, action: :write_song, starts_at: Time.current, ends_at: Time.current+ hours * ENV["SECONDS_PER_GAME_HOUR"].to_i }

  before do
    band.add_member(member1, skill: member1.primary_skill)
    band.add_member(member2, skill: member2.primary_skill)
  end

  subject do
    Sidekiq::Testing.inline! do
      described_class.perform_async band.to_global_id, hours, activity.to_global_id
    end
  end

  # it 'adds 1 happening' do
  #   @happenings = band.happenings.count
  #   subject
  #   expect(band.happenings.count).to eq(@happenings + 1)
  # end

  it 'broadcasts' do
    expect { subject }
      .to have_broadcasted_to("activity_notifications:#{band.manager_id}")
  end

  it 'sends an email' do
    expect { subject }
      .to have_enqueued_job(ActionMailer::Parameterized::DeliveryJob)
      .with('ManagerMailer', 'activity_completed', 'deliver_now', user: band.manager, band: band, activity: activity)
      .on_queue('mailers')
  end
end

require 'rails_helper'

RSpec.describe Band::PlayGigWorker, type: :worker do
  let(:band) { create :band }
  let(:gig) { create :gig, band: band, venue: create(:venue) }
  let(:hours) { 1 }
  let(:activity) { create :activity, action: :gig, starts_at: Time.current, ends_at: Time.current+ hours * ENV["SECONDS_PER_GAME_HOUR"].to_i }

  subject do
    Sidekiq::Testing.inline! do
      described_class.perform_async band.to_global_id, gig.to_global_id, hours, activity.id
    end
  end

  it 'adds two happenings' do
    @happenings = band.happenings.count
    subject
    expect(band.happenings.count).to eq(@happenings + 2)
  end

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

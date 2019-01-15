require 'rails_helper'

RSpec.describe Band::SpendMoney, type: :service do
  let(:member1) { create(:member, primary_skill: Skill.find_by_name('Keyboards')) }
  let(:member2) { create(:member, primary_skill: Skill.find_by_name('Drummer')) }
  let(:genre) { Genre.find_by_style('Drum & Bass') }
  let(:band) { create :band, genre: genre, manager: create(:manager) }

  before do
    band.add_member(member1, skill: member1.primary_skill)
    band.add_member(member2, skill: member2.primary_skill)
  end

  it 'should remove money to manager\'s account' do
    expect {
      described_class.call(band: band, amount: 123)
    }.to change{ band.manager.balance }.by(-123)
  end

  context 'low balance' do
    subject { described_class.call(band: band, amount: 300) }

    it 'should queue a low balance email' do
      expect { subject }
        .to have_enqueued_job(ActionMailer::Parameterized::DeliveryJob)
        .with('ManagerMailer', 'balance_getting_low', 'deliver_now', user: band.manager)
        .on_queue('mailers')
    end
  end

  context 'negative balance' do
    subject { described_class.call(band: band, amount: 600) }

    it 'should queue a negative balance email' do
      expect { subject }
        .to have_enqueued_job(ActionMailer::Parameterized::DeliveryJob)
        .with('ManagerMailer', 'balance_negative', 'deliver_now', user: band.manager)
        .on_queue('mailers')
    end
  end
end

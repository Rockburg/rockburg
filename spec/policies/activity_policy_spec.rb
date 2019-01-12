require 'rails_helper'

RSpec.describe ActivityPolicy do
  context 'anonymous' do
    let(:band) { create(:band) }
    let(:activity) { build(:activity, band: band) }
    subject { described_class.new(nil, activity) }

    it { is_expected.to forbid_action(:practice) }
    it { is_expected.to forbid_action(:write_song) }
    it { is_expected.to forbid_action(:gig) }
    it { is_expected.to forbid_action(:record_single) }
    it { is_expected.to forbid_action(:release) }
    it { is_expected.to forbid_action(:rest) }
  end

  context 'manager, your band' do
    let(:user) { create(:manager) }
    let(:band) { create(:band, manager: user) }
    let(:activity) { build(:activity, band: band) }
    subject { described_class.new(user, activity) }

    it { is_expected.to permit_action(:practice) }
    it { is_expected.to permit_action(:write_song) }
    it { is_expected.to permit_action(:gig) }
    it { is_expected.to permit_action(:record_single) }
    it { is_expected.to permit_action(:release) }
    it { is_expected.to permit_action(:rest) }
  end

  context 'manager, other band' do
    let(:user) { create(:manager) }
    let(:band) { create(:band) }
    let(:activity) { build(:activity, band: band) }
    subject { described_class.new(user, activity) }

    it { is_expected.to forbid_action(:practice) }
    it { is_expected.to forbid_action(:write_song) }
    it { is_expected.to forbid_action(:gig) }
    it { is_expected.to forbid_action(:record_single) }
    it { is_expected.to forbid_action(:release) }
    it { is_expected.to forbid_action(:rest) }
  end
end

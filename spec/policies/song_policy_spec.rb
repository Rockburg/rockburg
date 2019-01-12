require 'rails_helper'

RSpec.describe SongPolicy do
  context 'anonymous' do
    let(:song) { create(:song) }
    subject { described_class.new(nil, song) }

    it { is_expected.to forbid_action(:destroy) }
  end

  context 'manager, your band' do
    let(:user) { create(:manager) }
    let(:band) { create(:band, manager: user) }
    let(:song) { create(:song, band: band) }
    subject { described_class.new(user, song) }

    it { is_expected.to permit_action(:destroy) }
  end

  context 'manager, other band' do
    let(:user) { create(:manager) }
    let(:band) { create(:band) }
    let(:song) { create(:song, band: band) }
    subject { described_class.new(user, song) }

    it { is_expected.to forbid_action(:destroy) }
  end
end

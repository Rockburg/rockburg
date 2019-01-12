require 'rails_helper'

RSpec.describe MemberBandPolicy do
  context 'anonymous' do
    let(:band) { create(:band) }
    let(:member) { create(:member) }
    let(:member_band) { create(:member_band, band: band, member: member) }
    subject { described_class.new(nil, member_band) }

    it { is_expected.to forbid_action(:destroy) }
  end

  context 'manager, your band' do
    let(:user) { create(:manager) }
    let(:band) { create(:band, manager: user) }
    let(:member) { create(:member) }
    let(:member_band) { create(:member_band, band: band, member: member) }
    subject { described_class.new(user, member_band) }

    it { is_expected.to permit_action(:destroy) }

  end
  context 'manager, other band' do
    let(:user) { create(:manager) }
    let(:band) { create(:band) }
    let(:member) { create(:member) }
    let(:member_band) { create(:member_band, band: band, member: member) }
    subject { described_class.new(user, member_band) }

    it { is_expected.to permit_action(:destroy) }
  end
end

require 'rails_helper'

RSpec.describe BandPolicy do
  context 'anonymous' do
    let(:band) { create(:band) }
    subject { described_class.new(nil, band) }

    it { is_expected.to forbid_action(:create) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to permit_action(:happenings) }
    it { is_expected.to permit_action(:allmembers) }
    it { is_expected.to forbid_action(:hire_member) }
  end

  context 'manager, your band' do
    let(:user) { create(:manager) }
    let(:band) { create(:band, manager: user) }
    subject { described_class.new(user, band) }

    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:happenings) }
    it { is_expected.to permit_action(:allmembers) }
    it { is_expected.to permit_action(:hire_member) }
  end

  context 'manager, other band' do
    let(:user) { create(:manager) }
    let(:band) { create(:band) }
    subject { described_class.new(user, band) }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to permit_action(:happenings) }
    it { is_expected.to permit_action(:allmembers) }
    it { is_expected.to forbid_action(:hire_member) }
  end
end

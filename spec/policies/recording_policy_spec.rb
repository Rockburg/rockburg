require 'rails_helper'

RSpec.describe RecordingPolicy do
  context 'anonymous' do
    let(:recording) { create(:recording) }
    subject { described_class.new(nil, recording) }

    it { is_expected.to forbid_action(:destroy) }
  end

  context 'manager, your band' do
    let(:user) { create(:manager) }
    let(:recording) { create(:recording, band: create(:band, manager: user)) }
    subject { described_class.new(user, recording) }

    it { is_expected.to permit_action(:destroy) }
  end

  context 'manager, other band' do
    let(:user) { create(:manager) }
    let(:recording) { create(:recording) }
    subject { described_class.new(user, recording) }

    it { is_expected.to forbid_action(:destroy) }
  end
end

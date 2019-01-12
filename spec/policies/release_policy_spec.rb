require 'rails_helper'

RSpec.describe ReleasePolicy do
  context 'anonymous' do
    let(:release) { create(:release) }
    subject { described_class.new(nil, release) }

    it { is_expected.to forbid_action(:create) }
  end

  context 'manager, your band' do
    let(:user) { create(:manager) }
    let(:release) { create(:release, band: create(:band, manager: user)) }
    subject { described_class.new(user, release) }

    it { is_expected.to permit_action(:create) }
  end

  context 'manager, other band' do
    let(:user) { create(:manager) }
    let(:release) { create(:release) }
    subject { described_class.new(user, release) }

    it { is_expected.to forbid_action(:create) }
  end
end

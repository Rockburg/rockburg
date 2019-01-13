require 'rails_helper'

RSpec.describe ManagerPolicy do
  context 'anonymous' do
    let(:manager) { create(:manager) }
    subject { described_class.new(nil, manager) }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_action(:file_bankruptcy) }
  end

  context 'manager' do
    let(:manager) { create(:manager) }
    subject { described_class.new(manager, manager) }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:file_bankruptcy) }
  end
end

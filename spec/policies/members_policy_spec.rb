require 'rails_helper'

RSpec.describe MembersPolicy do
  context 'anonymous' do
    let(:member) { create(:member) }
    subject { described_class.new(nil, member) }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:hire) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'manager' do
    let(:user) { create(:manager) }
    let(:member) { create(:member) }
    subject { described_class.new(user, member) }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to permit_action(:hire) }
    it { is_expected.to permit_action(:destroy) }
  end
end

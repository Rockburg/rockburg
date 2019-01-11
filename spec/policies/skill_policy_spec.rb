require 'rails_helper'

RSpec.describe SkillPolicy do
  context 'anonymous' do
    let(:skill) { build(:skill) }
    subject { described_class.new(nil, skill) }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to permit_action(:show) }
  end
end

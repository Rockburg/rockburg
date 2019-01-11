require 'rails_helper'

RSpec.describe SkillsController, type: :controller do
  let(:current_manager) { create(:manager) }
  let(:skill) { create(:skill) }

  context '#index' do
    subject { get(:index) }

    context 'anonymous' do
      it 'should return not found' do
        expect { subject }.to raise_error(ActionController::RoutingError)
      end
    end

    context 'manager' do
      before { sign_in current_manager }

      it 'should return not found' do
        expect { subject }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  context '#snow' do
    subject { get(:show, params: { id: skill.id }) }

    context 'anonymous' do
      before { subject }

      it 'should return success' do
        expect(response.successful?).to eq(true)
      end
    end

    context 'manager' do
      before do
        subject
        sign_in current_manager
      end

      it 'should return success' do
        expect(response.successful?).to eq(true)
      end
    end
  end
end

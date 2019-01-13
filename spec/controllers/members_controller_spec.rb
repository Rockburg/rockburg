require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  let(:current_manager) { create(:manager) }
  let(:band) { create(:band, manager: current_manager) }
  let(:member) { create(:member) }
  let(:skill) { create(:skill) }

  before do
    create(:member_band, band: band, member: member)
  end

  context '#index' do
    subject { get(:index) }

    context 'anonymous' do
      before { subject }

      it 'should redirect' do
        expect(response.status).to be(302)
      end
    end

    context 'manager' do
      before { sign_in current_manager }

      it 'should return not found' do
        expect { subject }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  context '#show' do
    subject { get(:show, params: { id: member }) }

    context 'anonymous' do
      before { subject }

      it 'should redirect' do
        expect(response.status).to be(302)
      end
    end

    context 'manager' do
      before { sign_in current_manager }

      it 'should return success' do
        expect(response.successful?).to eq(true)
      end
    end
  end

  context '#edit' do
    subject { post(:edit, params: { id: current_manager.members.first.id }) }

    context 'anonymous' do
      before { subject }

      it 'should redirect' do
        expect(response.status).to be(302)
      end
    end

    context 'manager' do
      before { sign_in current_manager }

      it 'should return not found' do
        expect { subject }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  context '#new' do
    subject { get(:new) }

    context 'anonymous' do
      before { subject }

      it 'should redirect' do
        expect(response.status).to be(302)
      end
    end

    context 'manager' do
      before { sign_in current_manager }

      it 'should return not found' do
        expect { subject }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  context '#hire' do
    let(:new_member) { create(:member) }
    subject { get(:hire, params: { band_id: band.id, skill_id: skill.id, id: new_member.id }) }

    context 'anonymous' do
      before { subject }

      it 'should redirect' do
        expect(response.status).to be(302)
      end
    end

    context 'manager' do
      before { sign_in current_manager }

      it 'should return successful' do
        expect(response.successful?).to eq(true)
      end
    end
  end

  context '#destroy' do
    subject { delete(:destroy, params: { id: member.id }) }

    context 'anonymous' do
      before { subject }

      it 'should redirect' do
        expect(response.status).to be(302)
      end
    end

    context 'manager' do
      before { sign_in current_manager }

      it 'should return successful' do
        expect(response.successful?).to eq(true)
      end
    end
  end


  # context '#update' do
  #   before { get(:update) }

  #   it 'should return success' do
  #     expect(response.successful?).to eq(true)
  #   end
  # end
end

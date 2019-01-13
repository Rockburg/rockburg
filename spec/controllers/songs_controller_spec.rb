require 'rails_helper'

RSpec.describe SongsController, type: :controller do
  let(:current_manager) { create(:manager) }

  context '#index' do
    let(:band) { create(:band, manager: current_manager) }
    subject { get(:index, params: { band_id: band.id }) }

    context 'anonymous' do
      it 'should require session' do
        expect(subject).to redirect_to(new_manager_session_url)
      end
    end

    context 'manager' do
      before { sign_in current_manager }

      it 'should return not found' do
        expect { subject }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  context '#destroy, your band' do
    let(:band) { create(:band, manager: current_manager) }
    let(:song) { create(:song, band: band) }
    subject { delete(:destroy, params: { band_id: band.id, id: song.id }) }

    context 'anonymous' do
      it 'should not allow' do
        expect(subject).to redirect_to(new_manager_session_url)
      end
    end

    context 'manager' do
      before do
        sign_in current_manager
        subject
      end

      it 'should return success' do
        expect(response.status).to be(302)
      end
    end
  end

  context '#destroy, other band' do
    let(:band) { create(:band) }
    let(:song) { create(:song, band: band) }
    subject { delete(:destroy, params: { band_id: band.id, id: song.id }) }

    context 'anonymous' do
      it 'should not allow' do
        expect(subject).to redirect_to(new_manager_session_url)
      end
    end

    context 'manager' do
      before { sign_in current_manager }

      it 'should return to root' do
        expect(subject).to redirect_to(root_url)
      end
    end
  end
end

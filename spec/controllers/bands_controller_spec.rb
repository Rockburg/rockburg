require 'rails_helper'

RSpec.describe BandsController, type: :controller do
  let(:current_manager) { create(:manager) }

  context '#index' do
    subject { get(:index) }

    it 'renders not found' do
      expect { subject }.to raise_error(ActionController::RoutingError)
    end
  end

  context '#new' do
    subject { get(:new) }

    context 'anonymous' do
      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'manager' do
      before do
        sign_in create(:manager)
        subject
      end

      it 'renders 200 status code' do
        expect(response.status).to be(200)
      end
    end
  end

  context '#create' do
    let(:band) do
      {
        name: Generator.band_name,
        genre_id: Genre.first.id
      }
    end

    context 'anonymous' do
      subject { post(:create, params: { band: band } ) }

      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'manager' do
      before { sign_in create(:manager) }

      context 'creates band' do
        before { post(:create, params: { band: band } ) }

        it 'renders 302 status code' do
          expect(response.status).to be(302)
        end

        it 'creates band' do
          expect(Band.count).to be(1)
        end
      end
    end
  end

  context '#show' do
    let!(:band) { create(:band, manager: current_manager) }

    context 'anonymous' do
      subject { get(:show, params: { id: band.id }) }

      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'manager' do
      let!(:other_band) { create(:band, manager: create(:manager)) }
      subject { get(:show, params: { id: band.id }) }

      before do
        sign_in current_manager
        subject
      end

      it 'renders 200 status code' do
        expect(response.status).to be(200)
      end

      it 'renders 200 status code' do
        expect(response.status).to be(200)
      end
    end

    context 'other manager' do
      let!(:other_band) { create(:band, manager: create(:manager)) }
      subject { get(:show, params: { id: other_band.id }) }

      before do
        sign_in current_manager
        subject
      end

      it 'renders 200 status code' do
        expect(response.status).to be(200)
      end
    end
  end
end

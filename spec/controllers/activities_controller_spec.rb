require 'rails_helper'

RSpec.describe ActivitiesController, type: :controller do
  let(:current_manager) { create(:manager) }
  let(:band) { create(:band, manager: current_manager) }
  let(:other_band) { create(:band) }

  context '#practice' do
    context 'anonymous' do
      subject { get(:new, params: { band_id: band.id, type: :practice, hours: 1.minute } ) }

      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'manager, your band' do
      subject { get(:new, params: { band_id: band.id, type: :practice, hours: 1.minute } ) }
      before do
        sign_in current_manager
        subject
      end

      it 'renders 302 status code' do
        expect(response.status).to be(302)
      end

      it 'creates' do
        expect(Activity.count).to be(1)
      end
    end

    context 'manager, overly fatigued members' do
      subject { get(:new, params: { band_id: band.id, type: :practice, hours: 1.minute } ) }
      before do
        sign_in current_manager
        create(:member_band, band: band, member: create(:member, trait_fatigue: 105))
      end

      it 'redirects back to band path' do
        expect(subject).to redirect_to(band_path(band))
      end

      it 'flashes too tired' do
        subject
        expect(flash[:notice]).to eq('Your band is too tired!')
      end
    end

    context 'manager, other band' do
      subject { get(:new, params: { band_id: other_band.id, type: :practice, hours: 1.minute } ) }
      before { sign_in current_manager }

      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  context '#write_song' do
    context 'anonymous' do
      subject { get(:new, params: { band_id: band.id, type: :write_song, hours: 1.minute } ) }

      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'manager, your band' do
      subject { get(:new, params: { band_id: band.id, type: :write_song, hours: 1.minute } ) }
      before do
        sign_in current_manager
        subject
      end

      it 'renders 302 status code' do
        expect(response.status).to be(302)
      end

      it 'creates' do
        expect(Activity.count).to be(1)
      end
    end

    context 'manager, other band' do
      subject { get(:new, params: { band_id: other_band.id, type: :write_song, hours: 1.minute } ) }
      before { sign_in current_manager }

      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  context '#play_gig' do
    let(:venue) { create(:venue) }

    context 'anonymous' do
      subject { get(:new, params: { band_id: band.id, type: :gig, venue: venue, hours: 1.minute } ) }

      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'manager, your band' do
      subject { get(:new, params: { band_id: band.id, type: :gig, venue: venue, hours: 1.minute } ) }
      before do
        sign_in current_manager
        subject
      end

      it 'renders 302 status code' do
        expect(response.status).to be(302)
      end

      it 'creates' do
        expect(Activity.count).to be(1)
      end
    end

    context 'manager, other band' do
      subject { get(:new, params: { band_id: other_band.id, type: :gig, venue: venue, hours: 1.minute } ) }
      before { sign_in current_manager }

      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  context '#release' do
    let(:studio) { create(:studio) }
    let(:recording) { create(:recording, band: band, studio: studio) }

    context 'anonymous' do
      subject { get(:new, params: { band_id: band.id, type: :release, recording_ids: [recording.id], release: { name: Faker::FunnyName.name, kind: :album }, hours: 1.minute } ) }

      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'manager, your band' do
      subject { get(:new, params: { band_id: band.id, type: :release, recording_ids: [recording.id], release: { name: Faker::FunnyName.name, kind: :album }, hours: 1.minute } ) }
      before do
        sign_in current_manager
        subject
      end

      it 'renders 302 status code' do
        expect(response.status).to be(302)
      end

      it 'creates' do
        expect(Activity.count).to be(1)
      end
    end

    context 'manager, other band' do
      subject { get(:new, params: { band_id: other_band.id, type: :release, recording_ids: [recording.id], release: { name: Faker::FunnyName.name, kind: :album }, hours: 1.minute } ) }
      before do
        recording.update!(band: other_band)
        sign_in current_manager
      end

      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  context '#rest' do
    context 'anonymous' do
      subject { get(:new, params: { band_id: band.id, type: :rest, hours: 1.minute } ) }

      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'manager, your band' do
      subject { get(:new, params: { band_id: band.id, type: :rest, hours: 1.minute } ) }
      before do
        sign_in current_manager
        subject
      end

      it 'renders 302 status code' do
        expect(response.status).to be(302)
      end

      it 'creates' do
        expect(Activity.count).to be(1)
      end
    end

    context 'manager, other band' do
      subject { get(:new, params: { band_id: other_band.id, type: :rest, hours: 1.minute } ) }
      before { sign_in current_manager }

      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end
end

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

  context '#record_single' do
    let(:studio) { create(:studio) }
    let(:song) { create(:song, band: band) }

    context 'anonymous' do
      subject { get(:new, params: { band_id: band.id, type: :record_single, studio: { studio_id: studio.id, song_name: song.name }, song_id: song.id, hours: 1.minute } ) }

      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'manager, your band' do
      subject { get(:new, params: { band_id: band.id, type: :record_single, studio: { studio_id: studio.id, song_name: song.name }, song_id: song.id, hours: 1.minute } ) }
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
      subject { get(:new, params: { band_id: other_band.id, type: :record_single, studio: { studio_id: studio.id, song_name: song.name }, song_id: song.id, hours: 1.minute } ) }
      before do
        song.update!(name: Faker::FunnyName.name, band: other_band)
        sign_in current_manager
      end

      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  context '#record_album' do
    let(:studio) { create(:studio) }
    let(:recording) { create(:recording, band: band, studio: studio) }

    context 'anonymous' do
      subject { get(:new, params: { band_id: band.id, type: :record_album, studio: { studio_id: studio.id }, recording_ids: [recording.id], hours: 1.minute } ) }

      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'manager, your band' do
      subject { get(:new, params: { band_id: band.id, type: :record_album, studio: { studio_id: studio.id }, recording_ids: [recording.id], hours: 1.minute } ) }
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
      subject { get(:new, params: { band_id: other_band.id, type: :record_album, studio: { studio_id: studio.id }, recording_ids: [recording.id], hours: 1.minute } ) }
      before do
        recording.update!(band: other_band)
        sign_in current_manager
      end

      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  context '#release' do
    let(:studio) { create(:studio) }
    let(:recording) { create(:recording, band: band, studio: studio) }

    context 'anonymous' do
      subject { get(:new, params: { band_id: band.id, type: :release, recording: { id: recording.id }, hours: 1.minute } ) }

      it 'is not allowed' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'manager, your band' do
      subject { get(:new, params: { band_id: band.id, type: :release, recording: { id: recording.id }, hours: 1.minute } ) }
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
      subject { get(:new, params: { band_id: other_band.id, type: :release, recording: { id: recording.id }, hours: 1.minute } ) }
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

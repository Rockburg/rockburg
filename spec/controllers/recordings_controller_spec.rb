require 'rails_helper'

RSpec.describe RecordingsController, type: :controller do
  let!(:band) { create(:band) }
  let!(:recording) { create(:recording, band: band) }
  let(:current_manager) { create(:manager) }

  context '#destroy' do
    subject { delete(:destroy, params: { id: recording.id }) }

    # context 'anonymous' do
    #   it 'should redirect' do
    #     expect(subject).to redirect_to(root_url)
    #   end
    # end

    context 'manager' do
      before { sign_in current_manager }

      it 'should return success' do
        expect(response.successful?).to eq(true)
      end
    end
  end
end

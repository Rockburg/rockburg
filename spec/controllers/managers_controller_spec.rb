require 'rails_helper'

RSpec.describe ManagersController, type: :controller do
  let!(:current_manager) { create(:manager) }
  let!(:band) { create(:band, manager: current_manager) }

  before do
    @other_managers = create_list(:manager, 5)
    @other_managers.each do |manager|
      create(:band, manager: manager)
    end
    sign_in current_manager
  end

  context '#index' do
    subject { get(:index) }

    it 'should return success' do
      subject
      expect(response.successful?).to eq(true)
    end

    it 'renders show' do
      expect(subject).to render_template(:show)
    end

    it 'should set your bands' do
      subject
      expect(assigns(:bands)).to eq current_manager.bands.all
    end
  end

  context '#show' do
    before { get(:show, params: { id: current_manager.id }) }

    it 'should return success' do
      expect(response.successful?).to eq(true)
    end
  end

  context '#edit' do
    before { post(:edit, params: { id: current_manager.id }) }

    it 'should return success' do
      expect(response.successful?).to eq(true)
    end
  end

  context '#file_bankruptcy' do
    before do
      current_manager.update!(balance: -100)
      get(:file_bankruptcy, params: { id: current_manager.id })
    end

    it 'should return success' do
      expect(response.status).to be(302)
    end
  end
end

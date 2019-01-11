require 'rails_helper'

RSpec.describe ManagersController, type: :controller do
  let(:current_manager) { create(:manager) }

  before do
    @other_managers = create_list(:manager, 5)
    sign_in current_manager
  end

  context '#index' do
    before { get(:index) }

    it 'should return success' do
      expect(response.successful?).to eq(true)
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

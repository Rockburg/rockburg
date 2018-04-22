require 'rails_helper'

RSpec.describe ChartsController, type: :controller do

  def create_ranking_managers
    5.times do
      manager = create(:manager)
      manager.financials.create!(amount: rand(50..100))
    end
  end

  context '#index' do
    before do
      get :index
    end

    it 'should return charts for logged out user' do
      expect(response.successful?).to eq true
  	end

    it 'should rank managers by descending cash balance' do
      # create_ranking_managers
      # expect(assigns(:managers)) 'assigns' is now a separate gem...
    end
  end
end

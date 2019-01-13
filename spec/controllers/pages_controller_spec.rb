require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  context '#index' do
    before { get(:index) }

    it 'should return success' do
      expect(response.successful?).to eq(true)
    end
  end
end

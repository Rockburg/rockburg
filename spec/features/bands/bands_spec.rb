require 'rails_helper'

RSpec.feature 'Bands', :js => true do
  scenario 'Manager should be able to create bands' do
    register_manager
    feature_create_band

    expect(page).to have_content('Band created successfully')
    expect(page).to have_content('29 Minutes to Pluto')
    expect(page).to have_text('Hire this member')
  end
end

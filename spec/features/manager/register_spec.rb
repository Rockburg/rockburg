require 'rails_helper'

RSpec.feature 'Register', :js => true do
  scenario 'When manager signs up, should see dashboard with cash and bands menu' do
    register_manager
    expect(page).to have_content('Welcome!')
    expect(page).to have_content('§')
    expect(page).to have_text('Start a new band')
  end
end

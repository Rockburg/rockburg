require 'rails_helper'

RSpec.feature 'Login', :js => true do
  scenario 'When manager logs in, should see dashboard with activities menu' do
    manager = create(:manager)
    login_manager(manager.email)

    expect(page).to have_text('Profile')
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content(manager.name)
  end

  scenario 'When manager logs in with mixed case email, can still log in' do
    mixedcase_email = create(:manager).email.capitalize
    login_manager(mixedcase_email)
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'When manager logs in with wrong password' do
    login_manager(create(:manager).email, 'wrong_password')

    expect(page).not_to have_text('Profile')
    expect(page).not_to have_content('Signed in successfully.')
    expect(page).to have_text('Invalid Email or password')
  end
end

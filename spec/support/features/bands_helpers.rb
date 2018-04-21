def feature_create_band
  find_link('Start a new band', match: :first).click # multiple links present
  fill_in 'band[name]', with: '29 Minutes to Pluto'
  all('option')[-1].select_option # randomly select last genre
  click_button 'Start your band'
end

def register_manager
  visit new_manager_registration_path

  fill_in 'manager[name]',       with: 'Ryan'
  fill_in 'manager[email]',      with: 'rocker@test.com'
  fill_in 'manager[password]',   with: 'password'
  fill_in 'manager[password_confirmation]',  with: 'password'
  click_button 'Sign up'
  sleep(1)
end

def login_manager email, password = 'password'
  visit new_manager_session_path

  fill_in 'manager[email]', :with => email
  fill_in 'manager[password]', :with => password
  click_button 'Log in'
  sleep(1)
end

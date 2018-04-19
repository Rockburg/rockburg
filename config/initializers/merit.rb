# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongoid
  # config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grand badge if no
  # `:to` option is given. Default is 'User'.
  config.user_model_name = 'Manager'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  config.current_user_method = 'current_manager'
end

# Create application badges (uses https://github.com/norman/ambry)
badge_id = 0
[{
  id: (badge_id = badge_id+1), #1
  name: 'Newbie',
  description: 'Joined Rockburg'
}, {
  id: (badge_id = badge_id+1), #2
  name: 'Fresh Meat',
  description: 'Started first band'
}, {
  id: (badge_id = badge_id+1), #3
  name: 'Dreammaker',
  description: 'Hired first band member'
}, {
  id: (badge_id = badge_id+1), #4
  name: 'Practice Makes Perfect',
  description: 'First practice'
}, {
  id: (badge_id = badge_id+1), #5
  name: 'Shakespear',
  description: 'Write first song'
}, {
  id: (badge_id = badge_id+1), #6
  name: 'Spotlight',
  description: 'Played first gig'
}].each do |attrs|
  Merit::Badge.create! attrs
end

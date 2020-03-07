source 'https://rubygems.org'

ruby '2.7.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Framework
gem 'rails', '~> 6.0'

# Webserver
gem 'puma'

# Data
gem 'pg'
gem 'ensurance'  # lets you .ensure your models
gem 'faker'
gem 'seedbank'   # seed data organization

# Frontend
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# User Authentication
gem 'bcrypt', '~> 3.1.7'
gem 'devise', github: 'plataformatec/devise' # , ref: '88e9a85'

# Security
gem 'pundit'

# Background Processing
gem 'sidekiq'
gem 'e2mmap'
gem 'thwait' # Needed for sidekiq-scheduler dependency
gem 'sidekiq-scheduler'
gem 'sidekiq-failures', github: 'bsharpe/sidekiq-failures', branch: :master
gem 'sidekiq-global_id'

# Email
gem 'inky-rb', require: 'inky'
gem 'premailer-rails' # Stylesheet inlining for email

# Intra-App messaging
# gem 'wisper'

# Misc
gem 'awesome_print' # print anything in the console
gem 'colorize' # colored strings are nice for debugging
gem 'dotiw' # Better distance of time in words for Rails
gem 'fast_blank' # a booster for .blank?/.present? calls
gem 'interactor' # service objects
gem 'interactor-contracts' # interface contracts for service objects
gem 'sentry-raven' # logging
gem 'font-awesome-rails' # icons
gem 'figaro' # environment variables
gem 'httparty'

group :development, :test do
  gem 'pry'
  gem 'pry-byebug'
  gem 'factory_bot_rails'
  gem 'rspec-rails'

  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :test do
  gem 'pundit-matchers'
  gem 'rails-controller-testing'
  gem 'rspec-sidekiq'
  gem 'rspec_junit_formatter'
end

group :development do
  gem "better_errors" # Better error page for Rack apps
  gem "binding_of_caller"

  gem 'annotate', github: 'ctran/annotate_models', branch: :develop # Annotate models on migration
  gem 'bundleup', require: false # know which gems need updating
  gem 'hirb', github: 'bsharpe/hirb', branch: :master # nice record display in console
  gem 'rubocop', require: false # style cop
  gem 'foreman', require: false # running background workers
  gem 'listen'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data' # , platforms: [:mingw, :mswin, :x64_mingw, :jruby]

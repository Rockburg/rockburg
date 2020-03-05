require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rockburg
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.generators do |generate|
      generate.helper             false
      generate.javascript_engine  false
      generate.test_framework     :rspec
      generate.request_specs      false
      generate.routing_specs      false
      generate.stylesheets        false
      generate.view_specs         false
      generate.model_specs        false
      generate.factory_bot        dir: 'spec/factories/'
    end

    # ActiveRecord time_zone
    config.active_record.default_timezone = :utc
    config.active_record.time_zone_aware_types = %i[datetime time]

    config.autoload_paths << "#{Rails.root}/lib"
    config.eager_load_paths << "#{Rails.root}/lib"
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
  end
end

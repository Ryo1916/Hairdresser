# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hairdresser
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set default time zone
    config.time_zone = 'Tokyo'

    # Don't generate routes, system test files, stylesheets, javascripts.
    config.generators do |g|
      g.skip_routes false
      g.stylesheets false
      g.javascripts false
      g.system_tests false
      g.test_framework :rspec,
                       fixtures: false,
                       view_specs: false,
                       routing_specs: false
    end

    # Use encrypted secrets at each environments
    config.read_encrypted_secrets = true

    # TODO: if below line is not related to heroku, it can be deleted
    config.assets.initialize_on_precompile = false
  end
end

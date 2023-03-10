require_relative "boot"

require "rails/all"
require "csv"


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PortfolioDemo
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets            false
      generate.helper            false
      generate.test_framework    :rspec, fixture: false
      generate.helper_specs      false
      generate.routing_specs     false
      generate.view_specs        false
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # I18n translations
    config.i18n.available_locales = [:fr, :en] # Whitelist locales available for the application
    config.i18n.default_locale = :fr           # Set the default local language
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    # fix Faker locale
    Faker::Config.locale = :en

    # Timezone management
    config.time_zone = "Europe/Paris"

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.active_job.queue_adapter = :sidekiq
    config.exceptions_app = self.routes
  end
end

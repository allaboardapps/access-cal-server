require File.expand_path("../boot", __FILE__)
require "rails/all"
require "csv"
require "securerandom"
require "elasticsearch/rails/instrumentation"
require "elasticsearch/rails/lograge"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AccessCalServer
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = "UTC"

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.available_locales = [:en, :es]
    config.i18n.default_locale = :en

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Use sidekiq for job queue management
    config.active_job.queue_adapter = :sidekiq

    config.middleware.insert_before 0, "Rack::Cors", debug: true, logger: (-> { Rails.logger }) do
      allow do
        origins "*"

        resource(
          "/cors",
          headers: :any,
          methods: [:post],
          credentials: true,
          max_age: 0
        )

        resource(
          "*",
          headers: :any,
          methods: [:get, :post, :delete, :put, :options, :head],
          max_age: 0
        )
      end
    end
  end
end

ENV["RAILS_ENV"] ||= "test"
require "rake"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "rspec/json_expectations"
require "sidekiq/testing"
require "airborne"
require "elasticsearch/extensions/test/cluster/tasks"
require "paper_trail/frameworks/rspec"

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec::Sidekiq.configure do |config|
  config.clear_all_enqueued_jobs = true
  config.enable_terminal_colours = true
  config.warn_when_jobs_not_processed_by_sidekiq = false
end

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"

  config.include Devise::TestHelpers, type: :controller

  config.include FactoryGirl::Syntax::Methods

  config.include Rails.application.routes.url_helpers

  config.before :each, elasticsearch: true do
    [Event].each do |model|
      model.__elasticsearch__.create_index!
    end
  end

  config.after :each, elasticsearch: true do
    [Event].each do |model|
      model.__elasticsearch__.client.indices.delete index: Event.index_name
    end
  end

  config.include AbstractController::Translation
end

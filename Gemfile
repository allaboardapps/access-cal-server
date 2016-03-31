source "https://rubygems.org"

ruby "2.3.0"
gem "rails", "4.2.6"

gem "active_model_serializers", "0.10.0.rc4"
gem "activeadmin", "1.0.0.pre2"
gem "aws-sdk", "2.2.31"
gem "browser", "2.0.3"
gem "devise", "3.5.6"
gem "devise-async", "0.10.1"
gem "factory_girl_rails", "4.6.0"
gem "faker", "1.6.3"
gem "figaro", "1.1.1"
gem "haml-rails", "0.9.0"
gem "httparty", "0.13.7"
gem "jquery-rails", "4.1.1"
gem "kaminari", "0.16.3"
gem "lograge", "0.3.6"
gem "pg", "0.18.4"
gem "postmark-rails", "0.12.0"
gem "rack-cors", "0.4.0", require: "rack/cors"
gem "raygun4ruby", "1.1.9"
gem "redcarpet", "3.3.4"
gem "redis-rails", "4.0.0"
gem "rollbar", "2.8.3"
gem "sass-rails", "5.0.4"
gem "settingslogic", "2.0.9"
gem "sidekiq", "4.1.1"
gem "simple_form", "3.2.1"
gem "sinatra", "1.4.7", require: nil
gem "uglifier", "3.0.0"

group :production, :staging do
  gem "rails_12factor", "0.0.3"
  gem "puma", "3.2.0"
end

group :development do
  gem "better_errors", "2.1.1"
  gem "binding_of_caller", "0.7.2"
  gem "brakeman", "3.2.1", require: false
  gem "bundler-audit", "0.5.0", require: false
  gem "bullet", "5.0.0"
  gem "letter_opener", "1.4.1"
  gem "hakiri", "0.7.2", require: false
  gem "rails_db", "1.1.1"
  gem "rb-fsevent", "0.9.7", require: false
  gem "spring", "1.6.4"
  gem "spring-commands-rspec", "1.0.4"
  gem "web-console", "3.1.1"
end

group :development, :test do
  gem "airborne", "0.2.3"
  gem "byebug", "8.2.2"
  gem "capybara", "2.6.2"
  gem "database_cleaner", "1.5.1"
  gem "pry-rails", "0.3.4"
  gem "pry-remote", "0.1.8"
  gem "rspec-json_expectations", "1.3.0"
  gem "rspec-rails", "3.4.2"
  gem "rubocop", "0.39.0"
  gem "shoulda-matchers", "3.1.1"
end

group :test do
  gem "rspec_junit_formatter", "0.2.3"
  gem "rspec-sidekiq", "2.2.0"
  gem "test_after_commit", "1.0.0"
end

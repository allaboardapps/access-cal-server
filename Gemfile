source "https://rubygems.org"

ruby "2.3.0"
gem "rails", "4.2.5"

gem "active_model_serializers", "0.9.4"
gem "activeadmin", "1.0.0.pre2"
gem "aws-sdk", "2.2.11"
gem "browser", "1.1.0"
gem "devise", "3.5.3"
gem "devise-async", "0.10.1"
gem "factory_girl_rails", "4.5.0"
gem "faker", "1.6.1"
gem "figaro", "1.1.1"
gem "haml-rails", "0.9.0"
gem "httparty", "0.13.7"
gem "jquery-rails", "4.1.0"
gem "kaminari", "0.16.3"
gem "lograge", "0.3.5"
gem "pg", "0.18.4"
gem "rack-cors", "0.4.0", require: "rack/cors"
gem "raygun4ruby", "1.1.9"
gem "redcarpet", "3.3.4"
gem "redis-rails", "4.0.0"
gem "sass-rails", "5.0.4"
gem "settingslogic", "2.0.9"
gem "sidekiq", "4.0.2"
gem "simple_form", "3.2.1"
gem "sinatra", "1.4.6", require: nil
gem "uglifier", "2.7.2"

group :production, :staging do
  gem "rails_12factor", "0.0.3"
  gem "unicorn", "5.0.1"
end

group :development do
  gem "better_errors", "2.1.1"
  gem "binding_of_caller", "0.7.2"
  gem "brakeman", "3.1.4", require: false
  gem "bundler-audit", "0.4.0", require: false
  gem "bullet", "5.0.0"
  gem "letter_opener", "1.4.1"
  gem "hakiri", "0.7.2", require: false
  gem "rails_db", "1.1.1"
  gem "rb-fsevent", "0.9.7", require: false
  gem "spring", "1.6.2"
  gem "spring-commands-rspec", "1.0.4"
  gem "web-console", "3.0.0"
end

group :development, :test do
  gem "airborne", "0.2.2"
  gem "byebug", "8.2.1"
  gem "capybara", "2.5.0"
  gem "database_cleaner", "1.5.1"
  gem "pry-rails", "0.3.4"
  gem "pry-remote", "0.1.8"
  gem "rspec-json_expectations", "1.2.0"
  gem "rspec-rails", "3.4.0"
  gem "rubocop", "0.36.0"
  gem "shoulda-matchers", "3.1.0"
end

group :test do
  gem "rails-controller-testing", "0.0.3"
  gem "rspec-sidekiq", "2.2.0"
  gem "test_after_commit", "0.4.2"
end

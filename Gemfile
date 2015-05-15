source "https://rubygems.org"

ruby "2.2.2"
gem "rails", "4.2.1"

gem "active_model_serializers", "0.9.3"
gem "activeadmin", github: "activeadmin/activeadmin", branch: "master"
gem "aws-sdk", "2.0.43"
gem "browser", "0.8.0"
gem "devise", "3.4.1"
gem "devise-async", "0.9.0"
gem "factory_girl_rails", "4.5.0"
gem "faker", "1.4.3"
gem "figaro", "1.1.1"
gem "haml-rails", "0.9.0"
gem "httparty", "0.13.4"
gem "jquery-rails", "4.0.3"
gem "kaminari", "0.16.3"
gem "pg", "0.18.2"
gem "rack-cors", "0.4.0", require: "rack/cors"
gem "raygun4ruby", "1.1.6"
gem "redcarpet", "3.2.3"
gem "redis-rails", "4.0.0"
gem "sass-rails", "5.0.3"
gem "settingslogic", "2.0.9"
gem "sidekiq", "3.3.4"
gem "simple_form", "3.1.0"
gem "sinatra", "1.4.6", require: nil
gem "uglifier", "2.7.1"

group :production, :staging do
  gem "rails_12factor", "0.0.3"
  gem "unicorn", "4.9.0"
end

group :development do
  gem "better_errors", "2.1.1"
  gem "binding_of_caller", "0.7.2"
  gem "bullet", "4.14.7"
  gem "letter_opener", "1.4.0"
  gem "rb-fsevent", "0.9.4", require: false
  gem "spring", "1.3.6"
  gem "spring-commands-rspec", "1.0.4"
end

group :development, :test do
  gem "byebug", "4.0.5"
  gem "capybara", "2.4.4"
  gem "codeclimate-test-reporter", "0.4.7", require: nil
  gem "database_cleaner", "1.4.1"
  gem "hakiri", "0.7.2"
  gem "pry-rails", "0.3.4"
  gem "pry-remote", "0.1.8"
  gem "rspec-json_expectations", "1.2.0"
  gem "rspec-rails", "3.2.1"
  gem "rspec-sidekiq", "2.0.0"
  gem "rubocop", "0.31.0"
  gem "shoulda-matchers", "2.8.0"
  gem "web-console", "2.1.2"
end

group :test do
  gem "test_after_commit", "0.4.1"
end

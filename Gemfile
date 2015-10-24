source "https://rubygems.org"

ruby "2.2.3"
gem "rails", "4.2.4"

gem "active_model_serializers", "0.9.3"
gem "activeadmin", "1.0.0.pre2"
gem "aws-sdk", "2.1.31"
gem "browser", "1.0.1"
gem "devise", "3.5.2"
gem "devise-async", "0.10.1"
gem "factory_girl_rails", "4.5.0"
gem "faker", "1.5.0"
gem "figaro", "1.1.1"
gem "haml-rails", "0.9.0"
gem "httparty", "0.13.7"
gem "jquery-rails", "4.0.5"
gem "kaminari", "0.16.3"
gem "pg", "0.18.3"
gem "rack-cors", "0.4.0", require: "rack/cors"
gem "raygun4ruby", "1.1.8"
gem "redcarpet", "3.3.3"
gem "redis-rails", "4.0.0"
gem "sass-rails", "5.0.4"
gem "settingslogic", "2.0.9"
gem "sidekiq", "3.5.1"
gem "simple_form", "3.2.0"
gem "sinatra", "1.4.6", require: nil
gem "uglifier", "2.7.2"

group :production, :staging do
  gem "rails_12factor", "0.0.3"
  gem "unicorn", "4.9.0"
end

group :development do
  gem "better_errors", "2.1.1"
  gem "binding_of_caller", "0.7.2"
  gem "bullet", "4.14.10"
  gem "letter_opener", "1.4.1"
  gem "rails_db"
  gem "rb-fsevent", "0.9.6", require: false
  gem "spring", "1.4.0"
  gem "spring-commands-rspec", "1.0.4"
  gem "web-console", "2.2.1"
end

group :development, :test do
  gem "airborne", "0.1.20"
  gem "byebug", "6.0.2"
  gem "capybara", "2.5.0"
  gem "database_cleaner", "1.5.1"
  gem "hakiri", "0.7.2"
  gem "pry-rails", "0.3.4"
  gem "pry-remote", "0.1.8"
  gem "rspec-json_expectations", "1.2.0"
  gem "rspec-rails", "3.3.3"
  gem "rubocop", "0.34.2"
  gem "shoulda-matchers", "3.0.1"
end

group :test do
  gem "rails-controller-testing", "0.0.3"
  gem "test_after_commit", "0.4.1"
  gem "rspec-sidekiq", "2.1.0"
end

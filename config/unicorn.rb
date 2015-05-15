worker_processes 1
timeout 15
preload_app true

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!
  Rails.logger.info("Disconnected from ActiveRecord")
  sleep 1
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
  Rails.logger.info("Connected to ActiveRecord")
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV["REDIS_PROVIDER"] }
  end
  Rails.logger.info("Sidekiq client configured")
end

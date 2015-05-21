class WorkerExample
  # include Sidekiq::Worker
  # sidekiq_options queue: :default
  # sidekiq_options retry: 3
  # sidekiq_options unique: true

  # def perform
  #   User.do_something
  # end
end

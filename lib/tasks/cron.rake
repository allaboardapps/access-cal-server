namespace :cron do
  desc "Archive events where end date is past"
  task archived_expired_events: :environment do
    # ArchiveExpiredEvents.perform_async
    # puts "Creating job for archiving expired events"
  end
end

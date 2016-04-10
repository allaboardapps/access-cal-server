namespace :dummy do

  desc "delete all dummy data"
  task reload: :environment do
    Rake::Task["dummy:purge"].execute
    Rake::Task["dummy:load"].execute
  end

  desc "delete all dummy data"
  task purge: :environment do
    Rails.application.eager_load!

    ActiveRecord::Base.descendants.each do |model|
      begin
        model.dummies.destroy_all
        puts "Deleted all #{model} dummy data"
      rescue
        puts "[Error] #{model} not available"
      end
    end
  end

  desc "read the counts of all dummy data"
  task count: :environment do
    Rails.application.eager_load!
    ActiveRecord::Base.descendants.each do |model|
      begin
        count = model.dummies.count
        puts "Count of #{model} dummy data stands at #{count}"
      rescue
        puts "[Error] #{model} not available"
      end
    end
  end

  desc "create all dummy data"
  task load: :environment do
    puts "BEGIN: Creating dummy users"
    FactoryGirl.create :user, :admin, :dummy, email: "admin@test.com", password: "password-for-admin", password_confirmation: "password-for-admin"
    FactoryGirl.create :user, :staff, :dummy, email: "staff@test.com", password: "password-for-staff", password_confirmation: "password-for-staff"
    FactoryGirl.create :user, :client, :dummy, email: "client@test.com", password: "password-for-client", password_confirmation: "password-for-client"
    FactoryGirl.create :user, :consumer, :dummy, email: "consumer@test.com", password: "password-for-consumer", password_confirmation: "password-for-consumer"

    (1..5).each do |i|
      FactoryGirl.create :user, :client, :dummy
    end
    consumers = User.consumers.dummies

    (1..15).each do
      FactoryGirl.create :user, :consumer, :dummy
    end
    clients = User.clients.dummies
    puts "END:   Creating dummy users"

    puts "BEGIN: Creating organizations and groups"
    (1..5).each do
      FactoryGirl.create :organization, :dummy
    end
    organizations = Organization.dummies

    organizations.each do |organization|
      FactoryGirl.create :organization_user, :dummy, user: clients.limit(1).order("RANDOM()").first, organization: organization, role: OrganizationRoles.all.sample
      (2..5).each do
        group = FactoryGirl.create :group, :dummy, organization: organization
        (1..3).each do
          FactoryGirl.create :group_user, :dummy, group: group, user: clients.limit(1).order("RANDOM()").first, role: GroupRoles.all.sample
        end
      end
    end
    puts "END:   Creating organizations and groups"

    puts "BEGIN: Creating calendars and calendar_users"
    (1..rand(8..18)).each do
      FactoryGirl.create :calendar, :dummy
    end

    calendars = Calendar.dummies
    calendars.each do |calendar|
      (1..rand(5..8)).each do
        FactoryGirl.create :calendar_user, :dummy, calendar: calendar, user: clients.limit(1).order("RANDOM()").first, role: CalendarRoles.all.sample
      end
    end
    puts "END:   Creating calendars and calendar_users"

    puts "BEGIN: Creating events, event_users, and favorites"
    calendars.each do |calendar|
      (1..rand(15..40)).each do
        FactoryGirl.create :event, :dummy, calendar: calendar, author: calendar.users.limit(1).order("RANDOM()").first
      end
    end
    events = Event.dummies

    events.each do |event|
      FactoryGirl.create :event_user, :dummy, user: clients.limit(1).order("RANDOM()").first, role: EventRoles.all.sample
    end

    consumers.each do |consumer|
      (1..rand(5..15)).each do
        FactoryGirl.create :favorite, :dummy, user: consumer, event: Event.dummies.limit(1).order("RANDOM()").first
      end
    end
    puts "END:   Creating events, event_users, and favorites"

    puts "BEGIN: Creating activities"
    (1..20).each do
      FactoryGirl.create :activity, :dummy, creator: User.dummies.limit(1).order("RANDOM()").first, loggable: Event.dummies.limit(1).order("RANDOM()").first, activity_action_type: ActivityActionTypes.all.sample, description: Faker::Hipster.words(rand(5..12))
    end
    puts "END:   Creating activities"

    puts "BEGIN: Creating tags"
    FactoryGirl.create :tag, :dummy, name: "accessible entrances", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "accessible parking", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "accessible pathways", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "accessible restroom", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "air-conditioned", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "asl interpretation", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "assistive listening systems", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "audio description", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "audio version and taping", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "autism-friendly", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "braille material", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "closed captioning", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "communication access in real time", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "dietary options", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "large print", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "open captioning", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "reserved seating", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "service animal accomodations", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "touch tour", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "wheelchair or scooter accessible", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "wheelchair or scooter available", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    FactoryGirl.create :tag, :dummy, name: "banquet", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    FactoryGirl.create :tag, :dummy, name: "board meeting", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    FactoryGirl.create :tag, :dummy, name: "celebration", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    FactoryGirl.create :tag, :dummy, name: "colloquium", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    FactoryGirl.create :tag, :dummy, name: "conclave", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    FactoryGirl.create :tag, :dummy, name: "conference", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    FactoryGirl.create :tag, :dummy, name: "congress", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    FactoryGirl.create :tag, :dummy, name: "convention", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    FactoryGirl.create :tag, :dummy, name: "gala", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    FactoryGirl.create :tag, :dummy, name: "meeting", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    FactoryGirl.create :tag, :dummy, name: "performance", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    FactoryGirl.create :tag, :dummy, name: "seminar", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    FactoryGirl.create :tag, :dummy, name: "symposium", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    FactoryGirl.create :tag, :dummy, name: "trade show", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    FactoryGirl.create :tag, :dummy, name: "training", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    FactoryGirl.create :tag, :dummy, name: "workshop", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    FactoryGirl.create :tag, :dummy, name: "art", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "athletics", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "awards", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "comedy", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "concert", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "dance", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "education or class", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "fair or festival", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "film", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "food or drink", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "fundraiser", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "gallery or museum", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "holiday", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "kids or family", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "lecture", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "literature", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "music", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "networking", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "political", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "religious", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "shopping", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "social good", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "team building", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "theater", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    FactoryGirl.create :tag, :dummy, name: "tour", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT

    events.each do |event|
      FactoryGirl.create :event_tag, :dummy, event: event, tag: Tag.order("RANDOM()").limit(1).where(dummy: true, tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY).first
      FactoryGirl.create :event_tag, :dummy, event: event, tag: Tag.order("RANDOM()").limit(1).where(dummy: true, tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY).first
      FactoryGirl.create :event_tag, :dummy, event: event, tag: Tag.order("RANDOM()").limit(1).where(dummy: true, tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY).first
      FactoryGirl.create :event_tag, :dummy, event: event, tag: Tag.order("RANDOM()").limit(1).where(dummy: true, tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT).first
    end
    puts "END:   Creating events and favorites"
  end
end

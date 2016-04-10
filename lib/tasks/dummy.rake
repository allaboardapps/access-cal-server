namespace :dummy do

  desc "delete all dummy data"
  task delete_all: :environment do
    Rails.application.eager_load!

    ActiveRecord::Base.descendants.each do |model|
      begin
        model.dummy.destroy_all
        puts "Deleted all #{model} dummy data"
      rescue
        puts "[Error] #{model} not available"
      end
    end
  end

  desc "read the counts of all dummy data"
  task read_all: :environment do
    Rails.application.eager_load!
    ActiveRecord::Base.descendants.each do |model|
      begin
        count = model.dummy.count
        puts "Count of #{model} dummy data stands at #{count}"
      rescue
        puts "[Error] #{model} not available"
      end
    end
  end

  desc "create all dummy data"
  task create_all: :environment do
    puts "BEGIN: Creating dummy users"
    FactoryGirl.create :user, :admin, :dummy, email: "admin@test.com", password: "password-for-admin", password_confirmation: "password-for-admin"
    FactoryGirl.create :user, :staff, :dummy, email: "staff@test.com", password: "password-for-staff", password_confirmation: "password-for-staff"
    FactoryGirl.create :user, :client, :dummy, email: "client@test.com", password: "password-for-client", password_confirmation: "password-for-client"
    FactoryGirl.create :user, :consumer, :dummy, email: "consumer@test.com", password: "password-for-consumer", password_confirmation: "password-for-consumer"

    (1..5).each do |i|
      FactoryGirl.create :user, :client, :dummy
    end
    consumers = User.consumers.dummy

    (1..15).each do
      FactoryGirl.create :user, :consumer, :dummy
    end
    clients = User.clients.dummy
    puts "END:   Creating dummy users"

    puts "BEGIN: Creating organizations and groups"
    (1..5).each do
      FactoryGirl.create :organization, :dummy
    end
    organizations = Organization.dummy

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

    # puts "BEGIN: Creating calendars"
    # (1..10).each do
    #   FactoryGirl.create :calendar, :dummy, author: clients.limit(1).order("RANDOM()").first
    # end

    # calendars = Calendar.dummy
    # calendars.each do |calendar|
    #   (1..5).each do
    #     FactoryGirl.create :calendar_user, :dummy, calendar: calendar, user: clients.limit(1).order("RANDOM()").first, role: CalendarRoles.all.sample
    #   end
    # end
    # puts "END:   Creating organizations and groups"

    # puts "BEGIN: Creating events and favorites"
    # calendars.each do |calendar|
    #   FactoryGirl.create :event, author: client_1
    # end

    # consumers.each do |consumer|
    #   [1..10].each do
    #     FactoryGirl.create :favorite, user: consumer, event: Event.dummy.limit(1).order("RANDOM()").first
    #   end
    # end
    # puts "END:   Creating events and favorites"

    # FactoryGirl.create :activity, :dummy
    # FactoryGirl.create :tag, :dummy
    # FactoryGirl.create :region, :dummy
    # FactoryGirl.create :location, :dummy
  end
end

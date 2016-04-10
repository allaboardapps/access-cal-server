namespace :dummy do

  desc "delete all dummy data"
  task delete_all: :environment do
    CalendarUser.dummy.destroy_all
    GroupUser.dummy.destroy_all
    EventUser.dummy.destroy_all
    OrganizationUser.dummy.destroy_all
    EventTag.dummy.destroy_all
    Activity.dummy.destroy_all
    Calendar.dummy.destroy_all
    Group.dummy.destroy_all
    Event.dummy.destroy_all
    Favorite.dummy.destroy_all
    Organization.dummy.destroy_all
    User.dummy.destroy_all
    Tag.dummy.destroy_all
    Region.dummy.destroy_all
    Location.dummy.destroy_all
  end

  desc "create all dummy data"
  task create_all: :environment do
    # admin = FactoryGirl.create :user, :admin, :dummy, email: "admin@test.com", password: "password-for-admin"
    # staff = FactoryGirl.create :user, :staff, :dummy, email: "staff@test.com", password: "password-for-staff"
    client = FactoryGirl.create :user, :client, :dummy, email: "client@test.com", password: "password-for-client"
    # consumer = FactoryGirl.create :user, :consumer, test: true
    calendar = FactoryGirl.create :calendar, :dummy
    FactoryGirl.create :calendar_user, :dummy, calendar: calendar, user: client, role: CalendarRoles::OWNER
    # FactoryGirl.create :group_user, test: true
    # FactoryGirl.create :event_user, test: true
    # FactoryGirl.create :organization_user, test: true
    # FactoryGirl.create :event_tag, test: true
    # FactoryGirl.create :activity, test: true
    # FactoryGirl.create :calendar, test: true
    # FactoryGirl.create :group, test: true
    # FactoryGirl.create :event, test: true
    # FactoryGirl.create :favorite, test: true
    # FactoryGirl.create :organization, test: true
    # FactoryGirl.create :user, test: true
    # FactoryGirl.create :tag, test: true
    # FactoryGirl.create :region, test: true
    # FactoryGirl.create :location, test: true
  end
end

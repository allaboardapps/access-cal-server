class InitialSetup < ActiveRecord::Migration
  def change
    create_table :activities, id: :uuid, force: true do |t|
      t.uuid       :creator_id
      t.uuid       :loggable_id
      t.string     :loggable_type
      t.string     :activity_action_type
      t.string     :description
      t.boolean    :archived, default: false
      t.boolean    :test, default: false
      t.boolean    :dummy, default: false
      t.timestamps null: false
    end

    create_table :calendars, id: :uuid, force: true do |t|
      t.string     :name
      t.string     :abbreviation
      t.string     :time_zone, default: AllowedTimeZones::CENTRAL
      t.boolean    :archived, default: false
      t.boolean    :test, default: false
      t.boolean    :dummy, default: false
      t.timestamps null: false
    end

    create_table :calendar_users, id: :uuid, force: true do |t|
      t.uuid       :calendar_id
      t.uuid       :user_id
      t.string     :role
      t.boolean    :archived, default: false
      t.boolean    :test, default: false
      t.boolean    :dummy, default: false
      t.timestamps null: false
    end

    create_table :groups, id: :uuid, force: true do |t|
      t.uuid       :organization_id
      t.string     :name
      t.string     :group_type
      t.boolean    :archived, default: false
      t.boolean    :test, default: false
      t.boolean    :dummy, default: false
      t.timestamps null: false
    end

    create_table :group_users, id: :uuid, force: true do |t|
      t.uuid       :group_id
      t.uuid       :user_id
      t.string     :role
      t.boolean    :archived, default: false
      t.boolean    :test, default: false
      t.boolean    :dummy, default: false
      t.timestamps null: false
    end

    create_table :organizations, id: :uuid, force: true do |t|
      t.string     :name
      t.boolean    :archived, default: false
      t.boolean    :test, default: false
      t.boolean    :dummy, default: false
      t.timestamps null: false
    end

    create_table :organization_users, id: :uuid, force: true do |t|
      t.uuid       :organization_id
      t.uuid       :user_id
      t.string     :role
      t.boolean    :archived, default: false
      t.boolean    :test, default: false
      t.boolean    :dummy, default: false
      t.timestamps null: false
    end

    create_table :events, id: :uuid, force: true do |t|
      t.uuid       :author_id
      t.uuid       :location_id
      t.uuid       :calendar_id
      t.string     :name
      t.string     :abbreviation
      t.datetime   :starts_at
      t.datetime   :ends_at
      t.string     :description
      t.string     :street_address
      t.string     :secondary_address
      t.string     :city
      t.string     :state
      t.string     :country
      t.string     :zip_code
      t.string     :time_zone, default: AllowedTimeZones::CENTRAL
      t.float      :latitude
      t.float      :longitude
      t.string     :admin_notes
      t.boolean    :archived, default: false
      t.boolean    :test, default: false
      t.boolean    :dummy, default: false
      t.timestamps null: false
    end

    create_table :event_users, id: :uuid, force: true do |t|
      t.uuid       :event_id
      t.uuid       :user_id
      t.string     :role
      t.boolean    :archived, default: false
      t.boolean    :test, default: false
      t.boolean    :dummy, default: false
      t.timestamps null: false
    end

    create_table :event_tags, id: :uuid, force: true do |t|
      t.uuid       :event_id
      t.uuid       :tag_id
      t.boolean    :archived, default: false
      t.boolean    :test, default: false
      t.boolean    :dummy, default: false
      t.timestamps null: false
    end

    create_table :tags, id: :uuid, force: true do |t|
      t.string     :name
      t.string     :description
      t.string     :tag_type
      t.string     :tag_category
      t.boolean    :archived, default: false
      t.boolean    :test, default: false
      t.boolean    :dummy, default: false
      t.timestamps null: false
    end

    create_table :favorites, id: :uuid, force: true do |t|
      t.uuid       :user_id
      t.uuid       :event_id
      t.boolean    :archived, default: false
      t.boolean    :test, default: false
      t.boolean    :dummy, default: false
      t.timestamps null: false
    end

    create_table :regions, id: :uuid, force: true do |t|
      t.string     :name
      t.string     :abbreviation
      t.string     :time_zone, default: AllowedTimeZones::CENTRAL
      t.string     :admin_notes
      t.boolean    :archived, default: false
      t.boolean    :test, default: false
      t.boolean    :dummy, default: false
      t.timestamps null: false
    end

    create_table :locations, id: :uuid, force: true do |t|
      t.uuid       :region_id
      t.string     :name
      t.string     :abbreviation
      t.string     :time_zone, default: AllowedTimeZones::CENTRAL
      t.string     :admin_notes
      t.boolean    :archived, default: false
      t.boolean    :test, default: false
      t.boolean    :dummy, default: false
      t.timestamps null: false
    end

    create_table :reports, id: :uuid, force: true do |t|
      t.string     :name
      t.boolean    :archived, default: false
      t.boolean    :test, default: false
      t.boolean    :dummy, default: false
      t.timestamps null: false
    end
  end
end

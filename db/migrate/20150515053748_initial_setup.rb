class InitialSetup < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.integer    :creator_id
      t.references :loggable, polymorphic: true, index: true
      t.string     :activity_action_type
      t.string     :description
      t.timestamps null: false
    end

    create_table :calendars, id: :uuid, force: true do |t|
      t.string "name"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end

    create_table :calendar_users, id: :uuid, force: true do |t|
      t.uuid "calendar_id"
      t.uuid "user_id"
      t.string "role"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end

    create_table :groups, id: :uuid, force: true do |t|
      t.uuid "organization_id"
      t.string "name"
      t.string "group_type"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end

    create_table :group_users, id: :uuid, force: true do |t|
      t.uuid "group_id"
      t.uuid "user_id"
      t.string "role"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end

    create_table :organizations, id: :uuid, force: true do |t|
      t.string "name"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end

    create_table :organization_users, id: :uuid, force: true do |t|
      t.uuid "organization_id"
      t.uuid "user_id"
      t.string "role"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end

    create_table :events, id: :uuid, force: true do |t|
      t.uuid "author_id"
      t.uuid "location_id"
      t.string "name"
      t.string "abbreviation"
      t.string "primary_category"
      t.text "categories", array: true, default: []
      t.datetime "starts_at"
      t.datetime "ends_at"
      t.string "description"
      t.string "street_address"
      t.string "secondary_address"
      t.string "city"
      t.string "state"
      t.string "country"
      t.string "zip_code"
      t.string "time_zone"
      t.float "latitude"
      t.float "longitude"
      t.string "admin_notes"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end

    create_table :favorites, id: :uuid, force: true do |t|
      t.uuid "user_id"
      t.uuid "event_id"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end

    create_table :regions, id: :uuid, force: true do |t|
      t.string "name"
      t.string "abbreviation"
      t.string "time_zone"
      t.string "admin_notes"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end

    create_table :locations, id: :uuid, force: true do |t|
      t.uuid "region_id"
      t.string "name"
      t.string "abbreviation"
      t.string "time_zone"
      t.string "admin_notes"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end
  end
end

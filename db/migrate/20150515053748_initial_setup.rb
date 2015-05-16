class InitialSetup < ActiveRecord::Migration
  def change
    create_table "events", force: true do |t|
      t.string "name"
      t.string "abbreviation"
      t.string "timezone"
      t.string "admin_notes"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end

    create_table "favorites", force: true do |t|
      t.integer "user_id"
      t.integer "event_id"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end

    create_table "regions", force: true do |t|
      t.string "name"
      t.string "abbreviation"
      t.string "timezone"
      t.string "admin_notes"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end

    create_table "locations", force: true do |t|
      t.integer "region_id"
      t.string "name"
      t.string "abbreviation"
      t.string "timezone"
      t.string "admin_notes"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end
  end
end

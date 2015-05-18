# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150515053748) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "location_id"
    t.string   "name"
    t.string   "abbreviation"
    t.string   "primary_category"
    t.text     "categories",        default: [],    array: true
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string   "description"
    t.string   "street_address"
    t.string   "secondary_address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip_code"
    t.string   "time_zone"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "admin_notes"
    t.boolean  "archived",          default: false
    t.boolean  "test",              default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.boolean  "archived",   default: false
    t.boolean  "test",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "region_id"
    t.string   "name"
    t.string   "abbreviation"
    t.string   "time_zone"
    t.string   "admin_notes"
    t.boolean  "archived",     default: false
    t.boolean  "test",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.string   "time_zone"
    t.string   "admin_notes"
    t.boolean  "archived",     default: false
    t.boolean  "test",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "zip_code"
    t.string   "time_zone"
    t.string   "admin_notes"
    t.integer  "location_id"
    t.boolean  "archived",               default: false
    t.boolean  "test",                   default: false
    t.text     "roles",                  default: [],                 array: true
    t.text     "statuses",               default: [],                 array: true
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end

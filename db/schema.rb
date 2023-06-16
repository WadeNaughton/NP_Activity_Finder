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

ActiveRecord::Schema.define(version: 2023_06_16_145017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "description"
    t.string "date", default: [], array: true
    t.string "time"
    t.string "free"
    t.string "event_code"
    t.string "fee_info"
    t.float "latitude"
    t.float "longitude"
    t.string "type", default: [], array: true
  end

  create_table "parks", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "park_code"
    t.float "latitude"
    t.float "longitude"
    t.string "phone_number"
    t.string "email"
    t.string "entrance_fees", default: [], array: true
    t.string "directions_website"
    t.string "closed_day"
    t.string "operating_hours", default: [], array: true
    t.string "address"
    t.string "photos", default: [], array: true
  end

  create_table "user_events", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "park_id"
    t.bigint "event_id"
    t.index ["event_id"], name: "index_user_events_on_event_id"
    t.index ["park_id"], name: "index_user_events_on_park_id"
    t.index ["user_id"], name: "index_user_events_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "state"
    t.string "password_digest"
  end

  add_foreign_key "user_events", "events"
  add_foreign_key "user_events", "parks"
  add_foreign_key "user_events", "users"
end

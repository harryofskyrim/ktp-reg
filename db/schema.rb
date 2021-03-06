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

ActiveRecord::Schema.define(version: 20180629075933) do

  create_table "events", force: :cascade do |t|
    t.string "eventTitle"
    t.string "eventType"
    t.integer "teamMinSize"
    t.integer "teamMaxSize"
    t.date "dateStart"
    t.date "dateEnd"
    t.string "eventPlace"
    t.text "eventDescription"
    t.text "eventResults"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "fathersNameReq"
    t.boolean "bornReq"
    t.boolean "schoolReq"
    t.boolean "groupReq"
    t.boolean "phoneNumberReq"
    t.boolean "teeSizeReq"
    t.string "schoolType"
  end

  create_table "events_teams", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "team_id"
    t.index ["event_id"], name: "index_events_teams_on_event_id"
    t.index ["team_id"], name: "index_events_teams_on_team_id"
  end

  create_table "events_users", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.index ["event_id"], name: "index_events_users_on_event_id"
    t.index ["user_id"], name: "index_events_users_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "teamTitle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "schoolType"
  end

  create_table "teams_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "team_id"
    t.index ["team_id"], name: "index_teams_users_on_team_id"
    t.index ["user_id"], name: "index_teams_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "lastName"
    t.string "firstName"
    t.string "fathersName"
    t.date "born"
    t.string "email"
    t.string "phoneNumber"
    t.string "teeSize"
    t.string "occupation"
    t.string "school"
    t.string "group"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "cfhandle"
  end

end

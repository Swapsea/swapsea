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

ActiveRecord::Schema.define(version: 20181218074840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "trackable_type"
    t.integer  "trackable_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "key"
    t.text     "parameters"
    t.string   "recipient_type"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  end

  create_table "awards", force: :cascade do |t|
    t.string   "award_number",                null: false
    t.string   "award_name"
    t.integer  "user_id"
    t.date     "award_date"
    t.date     "proficiency_date"
    t.date     "expiry_date"
    t.date     "award_allocation_date"
    t.date     "proficiency_allocation_date"
    t.string   "originating_organisation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["award_name"], name: "index_awards_on_award_name", using: :btree
    t.index ["award_number"], name: "index_awards_on_award_number", unique: true, using: :btree
    t.index ["user_id"], name: "index_awards_on_user_id", using: :btree
  end

  create_table "clubs", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.boolean  "show_patrols"
    t.boolean  "show_rosters"
    t.boolean  "show_swaps"
    t.boolean  "show_outreach"
    t.boolean  "show_skills_maintenance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat",                     default: 0.0, null: false
    t.float    "lon",                     default: 0.0, null: false
    t.index ["name"], name: "index_clubs_on_name", using: :btree
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "emails", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "to"
    t.string   "cc"
    t.string   "bcc"
    t.string   "subject"
  end

  create_table "event_logs", force: :cascade do |t|
    t.string   "subject"
    t.string   "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leads", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "organisation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
  end

  create_table "notice_acknowledgements", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "notice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notices", force: :cascade do |t|
    t.string   "title"
    t.text     "desc"
    t.string   "link"
    t.string   "link_desc"
    t.string   "image"
    t.string   "video"
    t.integer  "user_id"
    t.boolean  "system_wide"
    t.datetime "visible_from"
    t.datetime "visible_to"
    t.boolean  "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "organisation"
  end

  create_table "offers", force: :cascade do |t|
    t.integer  "request_id"
    t.integer  "user_id"
    t.string   "comment"
    t.string   "mobile"
    t.string   "email"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roster_id"
    t.index ["request_id"], name: "index_offers_on_request_id", using: :btree
    t.index ["user_id"], name: "index_offers_on_user_id", using: :btree
  end

  create_table "outreach_patrol_sign_ups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "outreach_patrol_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["outreach_patrol_id"], name: "index_outreach_patrol_sign_ups_on_outreach_patrol_id", using: :btree
    t.index ["user_id"], name: "index_outreach_patrol_sign_ups_on_user_id", using: :btree
  end

  create_table "outreach_patrols", force: :cascade do |t|
    t.string   "location"
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "organisation"
  end

  create_table "patrol_members", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "default_position"
    t.string   "organisation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "patrol_name"
    t.index ["organisation"], name: "index_patrol_members_on_organisation", using: :btree
    t.index ["user_id"], name: "index_patrol_members_on_user_id", using: :btree
  end

  create_table "patrols", force: :cascade do |t|
    t.string   "name"
    t.boolean  "special_event"
    t.integer  "need_bbm",      null: false
    t.integer  "need_irbd",     null: false
    t.integer  "need_irbc",     null: false
    t.integer  "need_artc",     null: false
    t.integer  "need_firstaid", null: false
    t.integer  "need_spinal"
    t.integer  "need_bronze",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "need_src",      null: false
    t.string   "organisation"
    t.string   "short_name"
    t.index ["organisation", "name"], name: "index_patrols_on_organisation_and_name", using: :btree
  end

  create_table "proficiencies", force: :cascade do |t|
    t.string   "name"
    t.datetime "start"
    t.datetime "finish"
    t.integer  "max_signup"
    t.integer  "max_online_signup"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "organisation",      null: false
  end

  create_table "proficiency_signups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "proficiency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "roster_id"
    t.integer  "user_id"
    t.string   "comment"
    t.string   "mobile"
    t.string   "email"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["roster_id"], name: "index_requests_on_roster_id", using: :btree
    t.index ["user_id"], name: "index_requests_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "rosters", force: :cascade do |t|
    t.string   "organisation"
    t.string   "patrol_name"
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bbm"
    t.integer  "irbd"
    t.integer  "irbc"
    t.integer  "artc"
    t.integer  "spinal"
    t.integer  "firstaid"
    t.integer  "bronze"
    t.integer  "src"
    t.string   "secret"
    t.index ["organisation", "patrol_name"], name: "index_rosters_on_organisation_and_patrol_name", using: :btree
  end

  create_table "settings", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staging_awards", force: :cascade do |t|
    t.string   "award_number"
    t.string   "award_name"
    t.integer  "user_id"
    t.date     "award_date"
    t.date     "proficiency_date"
    t.date     "expiry_date"
    t.date     "award_allocation_date"
    t.date     "proficiency_allocation_date"
    t.string   "originating_organisation"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "staging_patrol_members", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "default_position"
    t.string   "organisation"
    t.string   "patrol_name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "staging_users", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "organisation"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "preferred_name"
    t.string   "mobile_phone"
    t.date     "dob"
    t.date     "date_joined_organisation"
    t.string   "category"
    t.string   "status"
    t.string   "season"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "swaps", force: :cascade do |t|
    t.integer  "roster_id"
    t.integer  "user_id"
    t.boolean  "on_off_patrol"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uniq_id"
    t.string   "trans_id"
    t.index ["roster_id"], name: "index_swaps_on_roster_id", using: :btree
    t.index ["user_id"], name: "index_swaps_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "organisation"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "preferred_name"
    t.string   "mobile_phone"
    t.date     "dob"
    t.date     "date_joined_organisation"
    t.string   "category"
    t.string   "status"
    t.string   "season"
    t.string   "gender"
    t.boolean  "account"
    t.string   "patrol_name"
    t.string   "default_position"
    t.string   "ics"
    t.boolean  "bbm"
    t.boolean  "irbd"
    t.boolean  "irbc"
    t.boolean  "artc"
    t.boolean  "spinal"
    t.boolean  "firstaid"
    t.boolean  "bronze"
    t.boolean  "src"
    t.boolean  "smsable",                  default: false
    t.index ["id"], name: "index_users_on_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

end

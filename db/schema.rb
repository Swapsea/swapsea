# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_08_18_110400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", id: :serial, force: :cascade do |t|
    t.string "trackable_type"
    t.integer "trackable_id"
    t.string "owner_type"
    t.integer "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.integer "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "club_id"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
  end

  create_table "api_credentials", id: :serial, force: :cascade do |t|
    t.string "api_key"
    t.string "api_secret"
    t.string "application_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "awards", id: :serial, force: :cascade do |t|
    t.string "award_number", null: false
    t.string "award_name"
    t.integer "user_id"
    t.date "award_date"
    t.date "proficiency_date"
    t.date "expiry_date"
    t.date "award_allocation_date"
    t.date "proficiency_allocation_date"
    t.string "originating_organisation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["award_name"], name: "index_awards_on_award_name"
    t.index ["award_number"], name: "index_awards_on_award_number", unique: true
    t.index ["user_id"], name: "index_awards_on_user_id"
  end

  create_table "clubs", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.boolean "show_patrols"
    t.boolean "show_rosters"
    t.boolean "show_swaps"
    t.boolean "show_outreach"
    t.boolean "show_skills_maintenance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "lat", default: 0.0, null: false
    t.float "lon", default: 0.0, null: false
    t.boolean "is_active", default: false
    t.boolean "enable_reminders_email", default: true
    t.boolean "enable_reminders_sms", default: false
    t.index ["name"], name: "index_clubs_on_name"
  end

  create_table "emails", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "to"
    t.string "cc"
    t.string "bcc"
    t.string "subject"
  end

  create_table "event_logs", id: :serial, force: :cascade do |t|
    t.string "subject"
    t.string "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leads", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "organisation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "phone"
  end

  create_table "notice_acknowledgements", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "notice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notices", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "desc"
    t.string "link"
    t.string "link_desc"
    t.string "image"
    t.string "video"
    t.integer "user_id"
    t.boolean "system_wide"
    t.datetime "visible_from"
    t.datetime "visible_to"
    t.boolean "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "club_id"
    t.index ["club_id"], name: "index_notices_on_club_id"
  end

  create_table "offers", id: :serial, force: :cascade do |t|
    t.integer "request_id"
    t.integer "user_id"
    t.string "comment"
    t.string "mobile"
    t.string "email"
    t.string "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "roster_id"
    t.string "decline_remark"
    t.index ["request_id"], name: "index_offers_on_request_id"
    t.index ["user_id"], name: "index_offers_on_user_id"
  end

  create_table "outreach_patrol_sign_ups", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "outreach_patrol_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["outreach_patrol_id"], name: "index_outreach_patrol_sign_ups_on_outreach_patrol_id"
    t.index ["user_id"], name: "index_outreach_patrol_sign_ups_on_user_id"
  end

  create_table "outreach_patrols", id: :serial, force: :cascade do |t|
    t.string "location"
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "club_id"
    t.index ["club_id"], name: "index_outreach_patrols_on_club_id"
  end

  create_table "patrol_members", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "default_position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "patrol_id"
    t.index ["patrol_id"], name: "index_patrol_members_on_patrol_id"
    t.index ["user_id"], name: "index_patrol_members_on_user_id"
  end

  create_table "patrols", id: :serial, force: :cascade do |t|
    t.string "name"
    t.boolean "special_event"
    t.integer "need_bbm", null: false
    t.integer "need_irbd", null: false
    t.integer "need_irbc", null: false
    t.integer "need_artc", null: false
    t.integer "need_firstaid", null: false
    t.integer "need_spinal"
    t.integer "need_bronze", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "need_src", null: false
    t.string "short_name"
    t.bigint "club_id"
    t.index ["club_id"], name: "index_patrols_on_club_id"
  end

  create_table "proficiencies", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "start"
    t.datetime "finish"
    t.integer "max_signup"
    t.integer "max_online_signup"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "club_id"
    t.index ["club_id"], name: "index_proficiencies_on_club_id"
  end

  create_table "proficiency_signups", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "proficiency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", id: :serial, force: :cascade do |t|
    t.integer "roster_id"
    t.integer "user_id"
    t.string "comment"
    t.string "mobile"
    t.string "email"
    t.string "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "nudge_email_opt_out", default: false
    t.datetime "nudge_email_opt_out_date"
    t.index ["roster_id"], name: "index_requests_on_roster_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "rosters", id: :serial, force: :cascade do |t|
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "bbm"
    t.integer "irbd"
    t.integer "irbc"
    t.integer "artc"
    t.integer "spinal"
    t.integer "firstaid"
    t.integer "bronze"
    t.integer "src"
    t.string "secret"
    t.bigint "patrol_id"
    t.index ["patrol_id"], name: "index_rosters_on_patrol_id"
  end

  create_table "staging_awards", id: :serial, force: :cascade do |t|
    t.string "award_number"
    t.string "award_name"
    t.integer "user_id"
    t.date "award_date"
    t.date "proficiency_date"
    t.date "expiry_date"
    t.date "award_allocation_date"
    t.date "proficiency_allocation_date"
    t.string "originating_organisation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "staging_patrol_members", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "default_position"
    t.string "organisation"
    t.string "patrol_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "staging_users", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "email"
    t.string "organisation"
    t.string "last_name"
    t.string "first_name"
    t.string "preferred_name"
    t.string "mobile_phone"
    t.date "dob"
    t.date "date_joined_organisation"
    t.string "category"
    t.string "status"
    t.string "season"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "swaps", id: :serial, force: :cascade do |t|
    t.integer "roster_id"
    t.integer "user_id"
    t.boolean "on_off_patrol"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "uniq_id"
    t.string "trans_id"
    t.index ["roster_id"], name: "index_swaps_on_roster_id"
    t.index ["user_id"], name: "index_swaps_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "last_name"
    t.string "first_name"
    t.string "preferred_name"
    t.string "mobile_phone"
    t.date "dob"
    t.date "date_joined_organisation"
    t.string "category"
    t.string "status"
    t.string "season"
    t.string "gender"
    t.boolean "account"
    t.string "default_position"
    t.string "ics"
    t.boolean "bbm"
    t.boolean "irbd"
    t.boolean "irbc"
    t.boolean "artc"
    t.boolean "spinal"
    t.boolean "firstaid"
    t.boolean "bronze"
    t.boolean "src"
    t.boolean "smsable", default: false
    t.bigint "club_id"
    t.index ["club_id"], name: "index_users_on_club_id"
    t.index ["id"], name: "index_users_on_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "notices", "clubs"
  add_foreign_key "outreach_patrols", "clubs"
  add_foreign_key "patrol_members", "patrols"
  add_foreign_key "patrols", "clubs"
  add_foreign_key "proficiencies", "clubs"
  add_foreign_key "rosters", "patrols"
  add_foreign_key "users", "clubs"
end

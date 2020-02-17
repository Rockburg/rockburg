# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_16_232345) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.bigint "band_id"
    t.string "action"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_activities_on_band_id"
  end

  create_table "bands", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "manager_id"
    t.bigint "genre_id"
    t.bigint "fans", default: 0
    t.bigint "buzz", default: 0
    t.index ["genre_id"], name: "index_bands_on_genre_id"
    t.index ["manager_id"], name: "index_bands_on_manager_id"
  end

  create_table "external_sentiments", force: :cascade do |t|
    t.string "source"
    t.jsonb "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "financials", force: :cascade do |t|
    t.bigint "manager_id", null: false
    t.bigint "band_id"
    t.bigint "activity_id"
    t.bigint "amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_financials_on_activity_id"
    t.index ["band_id"], name: "index_financials_on_band_id"
    t.index ["manager_id"], name: "index_financials_on_manager_id"
  end

  create_table "game_data", force: :cascade do |t|
    t.string "key"
    t.jsonb "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_game_data_on_key", unique: true
  end

  create_table "genre_skills", force: :cascade do |t|
    t.bigint "genre_id"
    t.bigint "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_genre_skills_on_genre_id"
    t.index ["skill_id"], name: "index_genre_skills_on_skill_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.string "style"
    t.integer "min_members"
    t.integer "max_members"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gigs", force: :cascade do |t|
    t.bigint "band_id"
    t.bigint "venue_id"
    t.integer "fans_gained"
    t.integer "money_made"
    t.date "played_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_gigs_on_band_id"
    t.index ["venue_id"], name: "index_gigs_on_venue_id"
  end

  create_table "happenings", force: :cascade do |t|
    t.bigint "band_id"
    t.string "what"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind"
    t.bigint "activity_id"
    t.index ["activity_id"], name: "index_happenings_on_activity_id"
    t.index ["band_id"], name: "index_happenings_on_band_id"
  end

  create_table "managers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.bigint "balance", default: 0
    t.integer "bands_count", default: 0
    t.datetime "last_seen_at"
    t.index ["balance"], name: "index_managers_on_balance"
    t.index ["email"], name: "index_managers_on_email", unique: true
  end

  create_table "member_bands", force: :cascade do |t|
    t.bigint "member_id"
    t.bigint "band_id"
    t.bigint "skill_id"
    t.datetime "joined_band_at"
    t.datetime "left_band_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_member_bands_on_band_id"
    t.index ["member_id"], name: "index_member_bands_on_member_id"
    t.index ["skill_id"], name: "index_member_bands_on_skill_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name", default: ""
    t.string "gender", default: ""
    t.date "birthdate"
    t.integer "cost", default: 0, null: false
    t.integer "trait_stamina", default: 0, null: false
    t.integer "trait_ego", default: 0, null: false
    t.integer "trait_looks", default: 0, null: false
    t.integer "trait_drive", default: 0, null: false
    t.integer "trait_productivity", default: 0, null: false
    t.integer "trait_aptitude", default: 0, null: false
    t.integer "trait_creativity", default: 0, null: false
    t.integer "trait_network", default: 0, null: false
    t.integer "trait_fatigue", default: 0, null: false
    t.integer "skill_primary"
    t.integer "skill_primary_level", default: 0
    t.integer "skill_secondary"
    t.integer "skill_secondary_level", default: 0
    t.integer "skill_tertiary"
    t.integer "skill_tertiary_level", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "passwordless_sessions", force: :cascade do |t|
    t.string "authenticatable_type"
    t.bigint "authenticatable_id"
    t.datetime "timeout_at", null: false
    t.datetime "expires_at", null: false
    t.datetime "claimed_at"
    t.text "user_agent", null: false
    t.string "remote_addr", null: false
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authenticatable_type", "authenticatable_id"], name: "authenticatable"
  end

  create_table "recordings", force: :cascade do |t|
    t.bigint "studio_id"
    t.bigint "band_id"
    t.integer "quality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "song_id"
    t.index ["band_id"], name: "index_recordings_on_band_id"
    t.index ["song_id"], name: "index_recordings_on_song_id"
    t.index ["studio_id"], name: "index_recordings_on_studio_id"
  end

  create_table "recordings_releases", id: false, force: :cascade do |t|
    t.bigint "recording_id", null: false
    t.bigint "release_id", null: false
    t.index ["recording_id", "release_id"], name: "index_recordings_releases_on_recording_id_and_release_id"
  end

  create_table "releases", force: :cascade do |t|
    t.bigint "band_id"
    t.string "name"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_releases_on_band_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "verb", default: "play"
  end

  create_table "songs", force: :cascade do |t|
    t.bigint "band_id"
    t.string "name"
    t.integer "quality", default: 0
    t.string "status", default: "writing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_songs_on_band_id"
  end

  create_table "streams", force: :cascade do |t|
    t.bigint "band_id"
    t.bigint "release_id"
    t.bigint "num_streams"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "for_date"
    t.index ["band_id"], name: "index_streams_on_band_id"
    t.index ["release_id"], name: "index_streams_on_release_id"
  end

  create_table "studios", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "engineer_name"
    t.integer "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "weight", default: 0
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bands", "genres"
  add_foreign_key "happenings", "activities"
  add_foreign_key "recordings", "songs"
  add_foreign_key "streams", "bands"
  add_foreign_key "streams", "releases"
end

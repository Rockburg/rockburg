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

ActiveRecord::Schema.define(version: 2018_04_23_163953) do

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

  create_table "badges_sashes", force: :cascade do |t|
    t.integer "badge_id"
    t.integer "sash_id"
    t.boolean "notified_user", default: false
    t.datetime "created_at"
    t.index ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id"
    t.index ["badge_id"], name: "index_badges_sashes_on_badge_id"
    t.index ["sash_id"], name: "index_badges_sashes_on_sash_id"
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
    t.index ["band_id"], name: "index_happenings_on_band_id"
  end

  create_table "managers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.bigint "balance", default: 0
    t.integer "bands_count", default: 0
    t.integer "sash_id"
    t.integer "level", default: 0
    t.datetime "last_seen_at"
    t.index ["balance"], name: "index_managers_on_balance"
    t.index ["email"], name: "index_managers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true
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

  create_table "merit_actions", force: :cascade do |t|
    t.integer "user_id"
    t.string "action_method"
    t.integer "action_value"
    t.boolean "had_errors", default: false
    t.string "target_model"
    t.integer "target_id"
    t.text "target_data"
    t.boolean "processed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merit_activity_logs", force: :cascade do |t|
    t.integer "action_id"
    t.string "related_change_type"
    t.integer "related_change_id"
    t.string "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: :cascade do |t|
    t.bigint "score_id"
    t.integer "num_points", default: 0
    t.string "log"
    t.datetime "created_at"
    t.index ["score_id"], name: "index_merit_score_points_on_score_id"
  end

  create_table "merit_scores", force: :cascade do |t|
    t.bigint "sash_id"
    t.string "category", default: "default"
    t.index ["sash_id"], name: "index_merit_scores_on_sash_id"
  end

  create_table "recordings", force: :cascade do |t|
    t.bigint "studio_id"
    t.bigint "band_id"
    t.string "kind"
    t.string "name"
    t.integer "quality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sales", default: 0
    t.datetime "release_at"
    t.index ["band_id"], name: "index_recordings_on_band_id"
    t.index ["studio_id"], name: "index_recordings_on_studio_id"
  end

  create_table "sashes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "single_albums", force: :cascade do |t|
    t.integer "album_id"
    t.integer "single_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "verb", default: "play"
  end

  create_table "song_recordings", force: :cascade do |t|
    t.bigint "recording_id"
    t.bigint "song_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recording_id"], name: "index_song_recordings_on_recording_id"
    t.index ["song_id"], name: "index_song_recordings_on_song_id"
  end

  create_table "songs", force: :cascade do |t|
    t.bigint "band_id"
    t.string "name"
    t.integer "quality", default: 0
    t.integer "streams", default: 0
    t.string "status", default: "writing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_songs_on_band_id"
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
end

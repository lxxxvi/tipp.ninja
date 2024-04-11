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

ActiveRecord::Schema[7.1].define(version: 2024_04_01_003001) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "communities", force: :cascade do |t|
    t.string "url_identifier", null: false
    t.string "name", null: false
    t.string "invitation_token", null: false
    t.integer "members_count", default: 1, null: false
    t.integer "average_points", default: 0, null: false
    t.string "access", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invitation_token"], name: "index_communities_on_invitation_token", unique: true
    t.index ["name"], name: "index_communities_on_name", unique: true
    t.index ["url_identifier"], name: "index_communities_on_url_identifier", unique: true
  end

  create_table "community_memberships", force: :cascade do |t|
    t.bigint "community_id", null: false
    t.bigint "user_id", null: false
    t.string "role", default: "member", null: false
    t.integer "ranking_position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id", "user_id"], name: "index_community_memberships_on_community_id_and_user_id", unique: true
    t.index ["community_id"], name: "index_community_memberships_on_community_id"
    t.index ["user_id"], name: "index_community_memberships_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "fifa_code", null: false
    t.string "name", null: false
    t.string "flag", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fifa_code"], name: "index_teams_on_fifa_code", unique: true
    t.index ["flag"], name: "index_teams_on_flag", unique: true
    t.index ["name"], name: "index_teams_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "url_identifier", null: false
    t.string "nickname", null: false
    t.string "email", null: false
    t.string "locale", default: "en", null: false
    t.boolean "admin", default: false, null: false
    t.bigint "rooting_for_team_id"
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["rooting_for_team_id"], name: "index_users_on_rooting_for_team_id"
    t.index ["url_identifier"], name: "index_users_on_url_identifier", unique: true
  end

  add_foreign_key "community_memberships", "communities"
  add_foreign_key "community_memberships", "users"
  add_foreign_key "users", "teams", column: "rooting_for_team_id"
end

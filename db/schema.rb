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

ActiveRecord::Schema.define(version: 20160706215412) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: :cascade do |t|
    t.integer  "user_id",         null: false
    t.integer  "game_id",         null: false
    t.integer  "team_home_goals"
    t.integer  "team_away_goals"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["game_id"], name: "index_bets_on_game_id", using: :btree
    t.index ["user_id"], name: "index_bets_on_user_id", using: :btree
  end

  create_table "championships", force: :cascade do |t|
    t.string   "name",        null: false
    t.datetime "started_at",  null: false
    t.datetime "finished_at", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "played_at",       null: false
    t.integer  "team_home_goals"
    t.integer  "team_away_goals"
    t.integer  "team_home_id",    null: false
    t.integer  "team_away_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "championship_id"
    t.string   "external_id"
    t.index ["championship_id"], name: "index_games_on_championship_id", using: :btree
    t.index ["external_id"], name: "index_games_on_external_id", using: :btree
    t.index ["team_away_id"], name: "index_games_on_team_away_id", using: :btree
    t.index ["team_home_id"], name: "index_games_on_team_home_id", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name",            null: false
    t.integer  "admin_id",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "championship_id"
    t.index ["admin_id"], name: "index_groups_on_admin_id", using: :btree
    t.index ["championship_id"], name: "index_groups_on_championship_id", using: :btree
  end

  create_table "members", force: :cascade do |t|
    t.integer  "group_id",                null: false
    t.integer  "user_id",                 null: false
    t.integer  "status",     default: 2,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points",     default: 0,  null: false
    t.integer  "position",   default: 0,  null: false
    t.jsonb    "positions",  default: {}, null: false
    t.index ["group_id"], name: "index_members_on_group_id", using: :btree
    t.index ["user_id"], name: "index_members_on_user_id", using: :btree
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree
  end

  create_table "rounds", force: :cascade do |t|
    t.string   "name",            null: false
    t.integer  "championship_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["championship_id"], name: "index_rounds_on_championship_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "external_id"
    t.index ["external_id"], name: "index_teams_on_external_id", using: :btree
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
    t.string   "nickname"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.boolean  "admin",                  default: false
    t.string   "provider"
    t.string   "uid"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end

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

ActiveRecord::Schema.define(version: 20140502004457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: true do |t|
    t.integer  "user_id",         null: false
    t.integer  "game_id",         null: false
    t.integer  "team_home_goals"
    t.integer  "team_away_goals"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bets", ["game_id"], name: "index_bets_on_game_id", using: :btree
  add_index "bets", ["user_id"], name: "index_bets_on_user_id", using: :btree

  create_table "championships", force: true do |t|
    t.string   "name",        null: false
    t.datetime "started_at",  null: false
    t.datetime "finished_at", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.datetime "played_at",       null: false
    t.integer  "team_home_goals"
    t.integer  "team_away_goals"
    t.integer  "team_home_id",    null: false
    t.integer  "team_away_id",    null: false
    t.integer  "round_id",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["round_id"], name: "index_games_on_round_id", using: :btree
  add_index "games", ["team_away_id"], name: "index_games_on_team_away_id", using: :btree
  add_index "games", ["team_home_id"], name: "index_games_on_team_home_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name",            null: false
    t.integer  "admin_id",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "championship_id"
  end

  add_index "groups", ["admin_id"], name: "index_groups_on_admin_id", using: :btree
  add_index "groups", ["championship_id"], name: "index_groups_on_championship_id", using: :btree

  create_table "members", force: true do |t|
    t.integer  "group_id",               null: false
    t.integer  "user_id",                null: false
    t.integer  "status",     default: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points",     default: 0, null: false
  end

  add_index "members", ["group_id"], name: "index_members_on_group_id", using: :btree
  add_index "members", ["user_id"], name: "index_members_on_user_id", using: :btree

  create_table "rounds", force: true do |t|
    t.string   "name",            null: false
    t.integer  "championship_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rounds", ["championship_id"], name: "index_rounds_on_championship_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

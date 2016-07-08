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

ActiveRecord::Schema.define(version: 201606211553501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blog_posts", force: :cascade do |t|
    t.string   "author"
    t.string   "content"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "remote_id"
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
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "friend_list_schedules", force: :cascade do |t|
    t.integer  "list_id"
    t.integer  "friend_id"
    t.string   "schedule"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friends", force: :cascade do |t|
    t.string   "username"
    t.integer  "user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "name"
    t.string   "bio"
    t.integer  "remote_id",  limit: 8
    t.string   "avatar"
    t.boolean  "following"
  end

  create_table "lists", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "remote_id",           limit: 8
    t.string   "url"
    t.integer  "days_until_rotation"
    t.string   "mode"
  end

  create_table "models", force: :cascade do |t|
    t.string   "friend_list_schedule"
    t.integer  "list_id"
    t.integer  "friend_id"
    t.string   "schedule"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "tweets", force: :cascade do |t|
    t.string   "tweet_text"
    t.integer  "user_id"
    t.integer  "remote_tweet_id",         limit: 8
    t.string   "source"
    t.integer  "emails_count"
    t.string   "html_block"
    t.datetime "remote_tweet_created_at"
    t.integer  "direct_messages_count"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "friend_id"
    t.boolean  "replied",                           default: false
    t.boolean  "viewed",                            default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "name"
    t.string   "location"
    t.string   "url"
    t.string   "image_url"
    t.string   "token"
    t.string   "secret"
    t.integer  "remote_id",  limit: 8
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "email"
    t.boolean  "shared",               default: false
  end

end

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

ActiveRecord::Schema.define(version: 20180426052455) do

  create_table "beeeers", force: :cascade do |t|
    t.string   "item_name",     limit: 255
    t.string   "image_url",     limit: 255
    t.integer  "price",         limit: 4
    t.integer  "price_per_can", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "product_url",   limit: 65535
  end

  create_table "hashtag_beeeers", force: :cascade do |t|
    t.integer  "hashtag_id", limit: 4
    t.integer  "beeeer_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "hashtag_beeeers", ["beeeer_id"], name: "index_hashtag_beeeers_on_beeeer_id", using: :btree
  add_index "hashtag_beeeers", ["hashtag_id"], name: "index_hashtag_beeeers_on_hashtag_id", using: :btree

  create_table "hashtags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "beeeer_id",  limit: 4, null: false
    t.integer  "user_id",    limit: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["beeeer_id"], name: "fk_rails_16defe289f", using: :btree
  add_index "likes", ["user_id"], name: "fk_rails_1e09b5dabf", using: :btree

  create_table "product_details", force: :cascade do |t|
    t.string   "brand",             limit: 255
    t.string   "manufacturer_name", limit: 255
    t.string   "package_type",      limit: 255
    t.string   "package_dim",       limit: 255
    t.string   "weight",            limit: 255
    t.string   "origin",            limit: 255
    t.text     "description",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "beeeer_id",         limit: 4
    t.string   "alcohol_by_degree", limit: 255
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "rate",       limit: 4
    t.text     "review",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "beeeer_id",  limit: 4
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "nickname",               limit: 255
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "hashtag_beeeers", "beeeers"
  add_foreign_key "hashtag_beeeers", "hashtags"
  add_foreign_key "likes", "beeeers"
  add_foreign_key "likes", "users"
end

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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110934123456) do

  create_table "assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["assetable_type", "assetable_id"], :name => "idx_assetable"
  add_index "assets", ["assetable_type", "type", "assetable_id"], :name => "idx_assetable_type"

  create_table "contents", :force => true do |t|
    t.integer  "group_id"
    t.string   "title"
    t.string   "author"
    t.string   "category"
    t.text     "body"
    t.boolean  "allow_comment"
    t.boolean  "state"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contents", ["group_id"], :name => "index_contents_on_group_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.string   "school"
    t.string   "slogan"
    t.string   "introduction"
    t.boolean  "is_audited"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "theme",        :default => "default"
  end

  create_table "members", :force => true do |t|
    t.integer  "authority"
    t.integer  "profile_id"
    t.integer  "group_id"
    t.boolean  "is_audited"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["authority"], :name => "index_members_on_authority"
  add_index "members", ["group_id"], :name => "index_members_on_group_id"
  add_index "members", ["is_audited"], :name => "index_members_on_is_audited"
  add_index "members", ["profile_id"], :name => "index_members_on_profile_id"

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.string   "school"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",              :null => false
    t.string   "encrypted_password"
    t.string   "persistence_token"
    t.string   "salt"
    t.string   "last_login_ip"
    t.datetime "last_login_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

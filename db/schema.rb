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

ActiveRecord::Schema.define(:version => 20110521003510) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "blocks", :force => true do |t|
    t.integer "cnn"
    t.string  "streetname"
    t.string  "suff"
    t.integer "botl"
    t.integer "topl"
    t.integer "botr"
    t.integer "topr"
    t.integer "txcnn"
    t.integer "bxcnn"
    t.string  "nhood"
    t.boolean "cleaned"
    t.string  "nct"
  end

  create_table "cleans", :force => true do |t|
    t.integer "cnn"
    t.string  "side"
    t.string  "wday"
    t.string  "start"
    t.string  "stop"
    t.string  "boolyuns"
    t.string  "dir"
    t.string  "nct"
    t.integer "ct_id"
    t.integer "block_id"
  end

  add_index "cleans", ["cnn"], :name => "index_cleans_on_cnn"

  create_table "cts", :force => true do |t|
    t.string "wday"
    t.string "start"
    t.string "stop"
    t.string "boolyuns"
    t.string "nct"
  end

  create_table "nhoods", :force => true do |t|
    t.string "nhood"
  end

  add_index "nhoods", ["nhood"], :name => "index_nhoods_on_nhood"

  create_table "points", :force => true do |t|
    t.integer "cnn"
    t.float   "lat"
    t.float   "lng"
  end

  add_index "points", ["cnn"], :name => "index_points_on_cnn"

  create_table "streets", :force => true do |t|
    t.string "streetname"
  end

  add_index "streets", ["streetname"], :name => "index_streets_on_streetname"

  create_table "suffixes", :force => true do |t|
    t.string "suff"
    t.string "alias"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "phone_number"
    t.string   "carrier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "xions", :force => true do |t|
    t.integer "xcnn"
    t.string  "streetname"
  end

  add_index "xions", ["xcnn"], :name => "index_xions_on_xcnn"

end

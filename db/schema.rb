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

ActiveRecord::Schema.define(version: 20170918110804) do

  create_table "shortened_urls", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "owner_id"
    t.string   "owner_type", limit: 20
    t.text     "url",        limit: 65535,             null: false
    t.string   "unique_key", limit: 10,                null: false
    t.integer  "use_count",                default: 0, null: false
    t.datetime "expires_at"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["owner_id", "owner_type"], name: "index_shortened_urls_on_owner_id_and_owner_type", using: :btree
    t.index ["unique_key"], name: "index_shortened_urls_on_unique_key", unique: true, using: :btree
    t.index ["url"], name: "index_shortened_urls_on_url", length: {"url"=>5}, using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "role"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
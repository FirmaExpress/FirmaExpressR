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

ActiveRecord::Schema.define(version: 20140610012845) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "documents", force: true do |t|
    t.string   "name"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "agreed_at"
  end

  create_table "invite_codes", force: true do |t|
    t.string  "code"
    t.boolean "available"
    t.integer "user_id"
  end

  add_index "invite_codes", ["user_id"], name: "index_invite_codes_on_user_id", using: :btree

  create_table "participants", force: true do |t|
    t.integer  "user_id",     null: false
    t.integer  "document_id", null: false
    t.integer  "role_id"
    t.boolean  "signed"
    t.datetime "signed_at"
  end

  add_index "participants", ["document_id"], name: "index_participants_on_document_id", using: :btree
  add_index "participants", ["role_id"], name: "index_participants_on_role_id", using: :btree
  add_index "participants", ["user_id"], name: "index_participants_on_user_id", using: :btree

  create_table "requested_sign_types", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "document_id"
    t.integer  "sign_type_id"
  end

  add_index "requested_sign_types", ["document_id"], name: "index_requested_sign_types_on_document_id", using: :btree
  add_index "requested_sign_types", ["sign_type_id"], name: "index_requested_sign_types_on_sign_type_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sign_types", force: true do |t|
    t.string "name"
  end

  create_table "signs", force: true do |t|
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "participant_id"
    t.integer  "sign_type_id"
  end

  add_index "signs", ["participant_id"], name: "index_signs_on_participant_id", using: :btree
  add_index "signs", ["sign_type_id"], name: "index_signs_on_sign_type_id", using: :btree

  create_table "user_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "id_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_type_id"
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
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["user_type_id"], name: "index_users_on_user_type_id", using: :btree

end

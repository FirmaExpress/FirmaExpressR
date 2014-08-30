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

ActiveRecord::Schema.define(version: 20140830173126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "documents", force: true do |t|
    t.string   "name"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "agreed_at"
    t.integer  "sign_security_level_id"
  end

  add_index "documents", ["sign_security_level_id"], name: "index_documents_on_sign_security_level_id", using: :btree

  create_table "invite_codes", force: true do |t|
    t.string  "code"
    t.boolean "available"
    t.integer "user_id"
  end

  add_index "invite_codes", ["user_id"], name: "index_invite_codes_on_user_id", using: :btree

  create_table "invoices", force: true do |t|
    t.string  "description"
    t.integer "total"
    t.integer "subscription_id"
  end

  add_index "invoices", ["subscription_id"], name: "index_invoices_on_subscription_id", using: :btree

  create_table "organization_users", force: true do |t|
    t.integer "user_id"
    t.integer "organization_id"
  end

  add_index "organization_users", ["organization_id"], name: "index_organization_users_on_organization_id", using: :btree
  add_index "organization_users", ["user_id"], name: "index_organization_users_on_user_id", using: :btree

  create_table "organizations", force: true do |t|
    t.string  "name"
    t.integer "subscriber_id"
  end

  add_index "organizations", ["subscriber_id"], name: "index_organizations_on_subscriber_id", using: :btree

  create_table "participants", force: true do |t|
    t.integer "user_id",     null: false
    t.integer "document_id", null: false
    t.integer "role_id"
    t.boolean "signed"
  end

  add_index "participants", ["document_id"], name: "index_participants_on_document_id", using: :btree
  add_index "participants", ["role_id"], name: "index_participants_on_role_id", using: :btree
  add_index "participants", ["user_id"], name: "index_participants_on_user_id", using: :btree

  create_table "plans", force: true do |t|
    t.string   "name"
    t.integer  "documents"
    t.boolean  "templates"
    t.boolean  "statistics"
    t.boolean  "admin_panel"
    t.boolean  "api"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sign_security_level_methods", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sign_security_method_id"
    t.integer  "sign_security_level_id"
  end

  add_index "sign_security_level_methods", ["sign_security_level_id"], name: "index_sign_security_level_methods_on_sign_security_level_id", using: :btree
  add_index "sign_security_level_methods", ["sign_security_method_id"], name: "index_sign_security_level_methods_on_sign_security_method_id", using: :btree

  create_table "sign_security_levels", force: true do |t|
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "description"
  end

  create_table "sign_security_methods", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "signs", force: true do |t|
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "participant_id"
  end

  add_index "signs", ["participant_id"], name: "index_signs_on_participant_id", using: :btree

  create_table "subscribers", force: true do |t|
  end

  create_table "subscriptions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plan_id"
    t.integer  "subscriber_id"
  end

  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree
  add_index "subscriptions", ["subscriber_id"], name: "index_subscriptions_on_subscriber_id", using: :btree

  create_table "used_sign_security_methods", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sign_id"
    t.integer  "sign_security_method_id"
  end

  add_index "used_sign_security_methods", ["sign_id"], name: "index_used_sign_security_methods_on_sign_id", using: :btree
  add_index "used_sign_security_methods", ["sign_security_method_id"], name: "index_used_sign_security_methods_on_sign_security_method_id", using: :btree

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
    t.integer  "subscriber_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["subscriber_id"], name: "index_users_on_subscriber_id", using: :btree
  add_index "users", ["user_type_id"], name: "index_users_on_user_type_id", using: :btree

end

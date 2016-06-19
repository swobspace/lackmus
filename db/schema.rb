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

ActiveRecord::Schema.define(version: 20160619151951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_rules", force: :cascade do |t|
    t.integer  "position"
    t.text     "filter",                 default: ""
    t.string   "action",      limit: 20
    t.integer  "severity",    limit: 2
    t.datetime "valid_until"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "event_rules", ["action"], name: "index_event_rules_on_action", using: :btree
  add_index "event_rules", ["position"], name: "index_event_rules_on_position", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "sensor",                                                      null: false
    t.datetime "event_time",                    precision: 6,                 null: false
    t.integer  "flow_id",            limit: 8
    t.string   "in_iface",           limit: 20,               default: ""
    t.string   "event_type",         limit: 20,               default: ""
    t.inet     "src_ip"
    t.integer  "src_port"
    t.inet     "dst_ip"
    t.integer  "dst_port"
    t.string   "proto",              limit: 20,               default: ""
    t.string   "alert_action",       limit: 20,               default: ""
    t.integer  "alert_gid"
    t.integer  "alert_signature_id"
    t.integer  "alert_rev"
    t.string   "alert_signature",                             default: ""
    t.string   "alert_category",                              default: ""
    t.integer  "alert_severity",     limit: 2
    t.string   "http_hostname",                               default: ""
    t.inet     "http_xff"
    t.string   "http_url",                                    default: ""
    t.string   "http_user_agent",                             default: ""
    t.string   "http_content_type",                           default: ""
    t.text     "http_cookie"
    t.integer  "http_length"
    t.integer  "http_status",        limit: 2
    t.string   "http_protocol",      limit: 20,               default: ""
    t.string   "http_method",        limit: 10,               default: ""
    t.string   "http_refer",                                  default: ""
    t.text     "payload"
    t.text     "packet"
    t.integer  "stream",             limit: 2
    t.boolean  "done",                                        default: false
    t.boolean  "ignore",                                      default: false
    t.boolean  "has_http",                                    default: false
    t.integer  "severity",           limit: 2
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
  end

  create_table "signatures", force: :cascade do |t|
    t.integer  "signature_id"
    t.string   "signature_info",            default: ""
    t.text     "references"
    t.string   "action",         limit: 20
    t.integer  "events_count"
    t.string   "category",                  default: ""
    t.integer  "severity",       limit: 2
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "signatures", ["action"], name: "index_signatures_on_action", using: :btree
  add_index "signatures", ["signature_id"], name: "index_signatures_on_signature_id", using: :btree

  create_table "wobauth_authorities", force: :cascade do |t|
    t.integer  "authorizable_id"
    t.string   "authorizable_type"
    t.integer  "role_id"
    t.integer  "authorized_for_id"
    t.string   "authorized_for_type"
    t.date     "valid_from"
    t.date     "valid_until"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wobauth_authorities", ["authorizable_id"], name: "index_wobauth_authorities_on_authorizable_id", using: :btree
  add_index "wobauth_authorities", ["authorized_for_id"], name: "index_wobauth_authorities_on_authorized_for_id", using: :btree
  add_index "wobauth_authorities", ["role_id"], name: "index_wobauth_authorities_on_role_id", using: :btree

  create_table "wobauth_groups", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wobauth_memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.boolean  "auto",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wobauth_memberships", ["group_id"], name: "index_wobauth_memberships_on_group_id", using: :btree
  add_index "wobauth_memberships", ["user_id"], name: "index_wobauth_memberships_on_user_id", using: :btree

  create_table "wobauth_roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wobauth_users", force: :cascade do |t|
    t.string   "username",               default: "", null: false
    t.text     "gruppen"
    t.string   "sn"
    t.string   "givenname"
    t.string   "displayname"
    t.string   "telephone"
    t.string   "active_directory_guid"
    t.string   "userprincipalname"
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
  end

  add_index "wobauth_users", ["reset_password_token"], name: "index_wobauth_users_on_reset_password_token", unique: true, using: :btree
  add_index "wobauth_users", ["username"], name: "index_wobauth_users_on_username", unique: true, using: :btree

end

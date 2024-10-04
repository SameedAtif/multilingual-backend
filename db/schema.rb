# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_10_04_125903) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "_prisma_migrations", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "checksum", limit: 64, null: false
    t.timestamptz "finished_at"
    t.string "migration_name", limit: 255, null: false
    t.text "logs"
    t.timestamptz "rolled_back_at"
    t.timestamptz "started_at", default: -> { "now()" }, null: false
    t.integer "applied_steps_count", default: 0, null: false
  end

  create_table "blacklisted_tokens", force: :cascade do |t|
    t.string "jti"
    t.bigint "user_id", null: false
    t.datetime "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_blacklisted_tokens_on_jti", unique: true
    t.index ["user_id"], name: "index_blacklisted_tokens_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "source_language"
    t.string "source_text"
    t.string "target_language"
    t.string "target_text"
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "resource_id", null: false
    t.string "resource_type", null: false
    t.string "user_type", null: false
    t.bigint "user_id"
    t.string "notification_type", null: false
    t.jsonb "extra"
    t.datetime "read_at"
    t.datetime "cleared_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_type", "resource_id"], name: "index_notifications_on_resource_type_and_resource_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "website", default: "", null: false
    t.bigint "owner_id", null: false
    t.bigint "current_assignee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "background_color"
    t.string "text_color"
    t.string "button_color"
    t.string "icon"
    t.string "label"
    t.string "greeting_message"
    t.index ["current_assignee_id"], name: "index_organizations_on_current_assignee_id"
    t.index ["owner_id"], name: "index_organizations_on_owner_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_participants_on_room_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "refresh_tokens", force: :cascade do |t|
    t.string "crypted_token"
    t.datetime "expires_at"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crypted_token"], name: "index_refresh_tokens_on_crypted_token", unique: true
    t.index ["user_id"], name: "index_refresh_tokens_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.boolean "is_private", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assignee_id"
    t.text "labels", array: true
    t.integer "status", default: 0
    t.bigint "organization_id"
    t.datetime "read_at"
    t.index ["assignee_id"], name: "index_rooms_on_assignee_id"
    t.index ["organization_id"], name: "index_rooms_on_organization_id"
  end

  create_table "shopify_sessions", id: :string, force: :cascade do |t|
    t.string "shop"
    t.string "state"
    t.boolean "is_online", default: false
    t.string "scope"
    t.datetime "expires"
    t.string "access_token"
    t.bigint "user_id"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.boolean "account_owner"
    t.string "locale"
    t.boolean "collaborator"
    t.boolean "email_verified"
    t.index ["user_id"], name: "index_shopify_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "token_issued_at"
    t.integer "user_type", default: 0, null: false
    t.bigint "organization_id"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.boolean "notification_conversation_assigned_email"
    t.boolean "notification_conversation_assigned_push"
    t.boolean "notification_message_received_email"
    t.boolean "notification_message_received_push"
    t.boolean "notification_message_reminder_email"
    t.boolean "notification_message_reminder_push"
    t.boolean "message_on_enter_key"
    t.string "language", default: "en", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "whitelisted_tokens", force: :cascade do |t|
    t.string "jti"
    t.bigint "user_id", null: false
    t.datetime "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_whitelisted_tokens_on_jti", unique: true
    t.index ["user_id"], name: "index_whitelisted_tokens_on_user_id"
  end

  add_foreign_key "blacklisted_tokens", "users"
  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "organizations", "users", column: "current_assignee_id"
  add_foreign_key "organizations", "users", column: "owner_id"
  add_foreign_key "participants", "rooms"
  add_foreign_key "participants", "users"
  add_foreign_key "refresh_tokens", "users"
  add_foreign_key "rooms", "organizations"
  add_foreign_key "rooms", "users", column: "assignee_id"
  add_foreign_key "shopify_sessions", "users"
  add_foreign_key "whitelisted_tokens", "users"
end

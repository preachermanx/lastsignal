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

ActiveRecord::Schema[8.1].define(version: 2026_04_03_110000) do
  create_table "audit_logs", force: :cascade do |t|
    t.string "action", null: false
    t.string "actor_type", null: false
    t.datetime "created_at", null: false
    t.string "ip_hash"
    t.json "metadata", default: {}
    t.datetime "updated_at", null: false
    t.string "user_agent_hash"
    t.bigint "user_id"
    t.index ["action"], name: "index_audit_logs_on_action"
    t.index ["created_at"], name: "index_audit_logs_on_created_at"
    t.index ["user_id", "created_at"], name: "index_audit_logs_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_audit_logs_on_user_id"
  end

  create_table "delivery_tokens", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "last_accessed_at"
    t.bigint "recipient_id", null: false
    t.datetime "revoked_at"
    t.string "token_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id", "created_at"], name: "index_delivery_tokens_on_recipient_id_and_created_at"
    t.index ["recipient_id"], name: "index_delivery_tokens_on_recipient_id"
    t.index ["token_digest"], name: "index_delivery_tokens_on_token_digest", unique: true
  end

  create_table "magic_link_tokens", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at", null: false
    t.string "ip_hash"
    t.string "token_digest", null: false
    t.datetime "updated_at", null: false
    t.datetime "used_at"
    t.string "user_agent_hash"
    t.bigint "user_id", null: false
    t.index ["expires_at"], name: "index_magic_link_tokens_on_expires_at"
    t.index ["token_digest"], name: "index_magic_link_tokens_on_token_digest", unique: true
    t.index ["user_id", "created_at"], name: "index_magic_link_tokens_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_magic_link_tokens_on_user_id"
  end

  create_table "message_recipients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "delivery_delay_hours", default: 0, null: false
    t.text "encrypted_msg_key_b64u", null: false
    t.string "envelope_algo", default: "crypto_box_seal", null: false
    t.integer "envelope_version", default: 1, null: false
    t.bigint "message_id", null: false
    t.bigint "recipient_id", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id", "recipient_id"], name: "index_message_recipients_on_message_id_and_recipient_id", unique: true
    t.index ["message_id"], name: "index_message_recipients_on_message_id"
    t.index ["recipient_id"], name: "index_message_recipients_on_recipient_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "aead_algo", default: "xchacha20poly1305_ietf", null: false
    t.text "ciphertext_b64u", null: false
    t.datetime "created_at", null: false
    t.string "label"
    t.text "nonce_b64u", null: false
    t.integer "payload_version", default: 1, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["created_at"], name: "index_messages_on_created_at"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "recipient_keys", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.json "kdf_params", default: {}, null: false
    t.text "kdf_salt_b64u", null: false
    t.integer "key_version", default: 1, null: false
    t.text "public_key_b64u", null: false
    t.bigint "recipient_id", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_recipient_keys_on_recipient_id", unique: true
  end

  create_table "recipients", force: :cascade do |t|
    t.datetime "accepted_at"
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.datetime "invite_expires_at"
    t.datetime "invite_sent_at"
    t.string "invite_token_digest"
    t.string "name"
    t.string "passphrase_hint", limit: 280
    t.string "state", default: "invited", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["invite_token_digest"], name: "index_recipients_on_invite_token_digest", unique: true
    t.index ["state"], name: "index_recipients_on_state"
    t.index ["user_id", "email"], name: "index_recipients_on_user_id_and_email", unique: true
    t.index ["user_id"], name: "index_recipients_on_user_id"
  end

  create_table "trusted_contacts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.datetime "last_confirmed_at"
    t.datetime "last_pinged_at"
    t.string "name"
    t.integer "pause_duration_hours"
    t.datetime "paused_until"
    t.string "token_digest"
    t.datetime "token_expires_at"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["token_digest"], name: "index_trusted_contacts_on_token_digest", unique: true
    t.index ["user_id"], name: "index_trusted_contacts_on_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.integer "checkin_attempt_interval_hours"
    t.integer "checkin_attempts"
    t.integer "checkin_attempts_sent", default: 0, null: false
    t.integer "checkin_interval_hours"
    t.string "checkin_token_digest"
    t.datetime "cooldown_warning_sent_at"
    t.datetime "created_at", null: false
    t.datetime "delivered_at"
    t.datetime "delivery_notice_sent_at"
    t.string "email", null: false
    t.datetime "external_checkin_last_used_at"
    t.string "external_checkin_token_digest"
    t.datetime "external_checkin_token_generated_at"
    t.datetime "last_checkin_attempt_at"
    t.datetime "last_checkin_confirmed_at"
    t.datetime "next_checkin_at"
    t.string "recovery_code_digest"
    t.datetime "recovery_code_viewed_at"
    t.string "state", default: "active", null: false
    t.datetime "updated_at", null: false
    t.index ["checkin_token_digest"], name: "index_users_on_checkin_token_digest", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["external_checkin_token_digest"], name: "index_users_on_external_checkin_token_digest", unique: true
    t.index ["next_checkin_at"], name: "index_users_on_next_checkin_at"
    t.index ["state", "next_checkin_at"], name: "index_users_on_state_and_next_checkin_at"
    t.index ["state"], name: "index_users_on_state"
  end

  add_foreign_key "audit_logs", "users"
  add_foreign_key "delivery_tokens", "recipients"
  add_foreign_key "magic_link_tokens", "users"
  add_foreign_key "message_recipients", "messages"
  add_foreign_key "message_recipients", "recipients"
  add_foreign_key "messages", "users"
  add_foreign_key "recipient_keys", "recipients"
  add_foreign_key "recipients", "users"
  add_foreign_key "trusted_contacts", "users"
end

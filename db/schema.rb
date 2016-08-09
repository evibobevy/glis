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


ActiveRecord::Schema.define(version: 20160805142440) do


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.text     "commenter"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree

  create_table "contact_requests", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "company_name"
    t.string   "phone_number"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_message_recipients", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "email_message_id"
  end

  create_table "email_messages", force: true do |t|
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "parent_id"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.datetime "event_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "end_date"
    t.datetime "start_time"
    t.string   "location"
    t.text     "basic_info"
    t.text     "full_description"
    t.string   "foundation_name"
    t.boolean  "recurring",          default: true
    t.boolean  "open_to_the_public", default: true
    t.boolean  "anyone_volunteer",   default: true
    t.time     "event_start_time"
    t.time     "event_end_time"
    t.integer  "user_role"
    t.integer  "type_of_gig"
    t.integer  "user_id"
  end

  create_table "events_users", force: true do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.boolean "join_event", default: false
  end

  create_table "events_volunteers", force: true do |t|
    t.integer "event_id"
    t.integer "volunteer_id"
  end

  create_table "foundation_friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "accepted"
  end

  create_table "foundation_pictures", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "foundation_id"
  end

  create_table "foundations", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "everyone_view_profile",                             default: true
    t.boolean  "everyone_view_calendar",                            default: true
    t.boolean  "everyone_invite_you_to_events",                     default: true
    t.boolean  "everyone_view_posts",                               default: true
    t.boolean  "everyone_message_you",                              default: true
    t.boolean  "volunteers_need_approval_to_join_your_gigs",        default: true
    t.boolean  "supporters_need_approval_to_comment_on_your_posts", default: true
    t.boolean  "email_notifications",                               default: true
    t.boolean  "text_notifications",                                default: true
    t.boolean  "mobile_ping_notifications",                         default: true
    t.string   "phone_number"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "type_of_foundation"
    t.integer  "user_role"
    t.integer  "user_id"
    t.boolean  "recurring",                                         default: true
    t.boolean  "open_to_the_public",                                default: true
    t.boolean  "anyone_volunteer",                                  default: true
    t.text     "basic_info"
  end


  create_table "foundations_users", force: true do |t|
    t.integer "foundation_id"
    t.integer "user_id"
  end


  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "accepted"
    t.boolean  "removed_user",   default: false
    t.boolean  "removed_friend", default: false
  end

  create_table "pictures", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "event_id"
  end

  create_table "posts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "postable_id"
    t.string   "postable_type"
  end

  add_index "posts", ["postable_type", "postable_id"], name: "index_posts_on_postable_type_and_postable_id", using: :btree

  create_table "user_pictures", force: true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                                   default: "",   null: false
    t.string   "encrypted_password",                      default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                           default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "provider"
    t.string   "uid"
    t.string   "profile_image"
    t.string   "confirm_email"
    t.string   "timezone"
    t.string   "city"
    t.text     "description"
    t.string   "state"
    t.string   "phone_number"
    t.boolean  "everyone_view_your_profile",              default: true
    t.boolean  "everyone_view_your_calendar",             default: true
    t.boolean  "everyone_invite_you_to_events",           default: true
    t.boolean  "everyone_view_your_post",                 default: true
    t.boolean  "everyone_message_you",                    default: true
    t.boolean  "volunteers_need_approval_join_your_gigs", default: true
    t.boolean  "supporters_need_approval_to_comment",     default: true
    t.boolean  "email_notification",                      default: true
    t.boolean  "sms_notification",                        default: true
    t.boolean  "mobile_ping_notifications",               default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "volunteers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

end

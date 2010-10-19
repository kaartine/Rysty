# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 27) do

  create_table "admins", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "club_admins", :force => true do |t|
    t.integer  "user_id"
    t.datetime "valid_until"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clubs", :force => true do |t|
    t.integer  "contact_info_id"
    t.string   "name"
    t.string   "short_name",      :limit => 6
    t.integer  "starp_year"
    t.string   "logo_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_infos", :force => true do |t|
    t.string   "phone_number_1"
    t.string   "phone_number_2"
    t.string   "phone_number_3"
    t.string   "address"
    t.string   "postal_code"
    t.string   "city"
    t.string   "country"
    t.string   "email"
    t.string   "facebook"
    t.string   "homepage"
    t.string   "twitter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contest_photos", :force => true do |t|
    t.integer  "contest_id"
    t.integer  "user_id"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contest_teams", :force => true do |t|
    t.integer  "contest_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contest_videos", :force => true do |t|
    t.integer  "contest_id"
    t.integer  "user_id"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contests", :force => true do |t|
    t.integer  "league_id"
    t.string   "name"
    t.string   "short_name",     :limit => 6
    t.text     "description"
    t.boolean  "public_profile",              :default => true
    t.integer  "season"
    t.integer  "climing"
    t.integer  "play_off_line"
    t.integer  "demotion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_comments", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_photos", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_stories", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.text     "story"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", :force => true do |t|
    t.integer  "contact_info_id"
    t.string   "name"
    t.string   "short_name",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_teams", :force => true do |t|
    t.integer  "team_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_videos", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "users_id"
    t.text     "description"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followed_contests", :force => true do |t|
    t.integer  "contest_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_photos", :force => true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_stories", :force => true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.text     "story"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_videos", :force => true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.integer  "home_team_id"
    t.integer  "guest_team_id"
    t.integer  "contest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "league_admins", :force => true do |t|
    t.integer  "user_id"
    t.datetime "valid_until"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.text     "description"
    t.boolean  "participating"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_admins", :force => true do |t|
    t.integer  "user_id"
    t.datetime "valid_until"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_member_photos", :force => true do |t|
    t.integer  "team_member_id"
    t.integer  "user_id"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_member_videos", :force => true do |t|
    t.integer  "team_member_id"
    t.integer  "user_id"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.integer  "contact_info_id"
    t.integer  "club_id"
    t.boolean  "public_profile"
    t.string   "short_name",      :limit => 6
    t.string   "name"
    t.integer  "season"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.integer  "height"
    t.integer  "weight"
    t.string   "username"
    t.boolean  "public_profile",                :default => false
    t.string   "password",        :limit => 40
    t.string   "salt",            :limit => 40
    t.integer  "contact_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

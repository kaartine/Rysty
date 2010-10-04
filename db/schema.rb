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

ActiveRecord::Schema.define(:version => 20100228151422) do

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.date     "founded"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_informations", :force => true do |t|
    t.string   "phone_number"
    t.string   "address"
    t.string   "postal_code"
    t.string   "city"
    t.string   "country"
    t.text     "description"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "place"
    t.time     "time"
    t.date     "date"
    t.text     "description"
    t.integer  "participants_id"
    t.integer  "oraganizer_id"
    t.string   "event_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.integer  "first_referee_id"
    t.integer  "second_referee_id"
    t.string   "trustee1"
    t.string   "trustee2"
    t.string   "trustee3"
    t.text     "aob"
    t.integer  "num_of_spectators"
    t.integer  "hall_id"
    t.integer  "home_team_id"
    t.integer  "guest_team_id"
    t.integer  "serie_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goals", :force => true do |t|
    t.time     "time"
    t.boolean  "penalty_shot"
    t.boolean  "delayed_penalty"
    t.boolean  "missed_penalty"
    t.boolean  "en"
    t.boolean  "pp"
    t.boolean  "sh"
    t.boolean  "equal"
    t.integer  "scorer_id"
    t.integer  "assister_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "halls", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "number_of_fields"
    t.integer  "contact_information_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "head_lines", :force => true do |t|
    t.date     "posted"
    t.string   "title"
    t.text     "content"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "penalties", :force => true do |t|
    t.time     "time"
    t.integer  "reason"
    t.integer  "minutes"
    t.time     "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.integer  "height"
    t.integer  "weight"
    t.text     "description"
    t.string   "nick_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "left_handed"
  end

  create_table "player_statistics", :force => true do |t|
    t.integer  "plusminus"
    t.integer  "number"
    t.boolean  "captain"
    t.boolean  "assistant_captain"
    t.boolean  "goalie"
    t.time     "game_time"
    t.integer  "saved_shots"
    t.integer  "goals_against"
    t.integer  "player_id"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.integer  "number"
    t.string   "stick"
    t.string   "position"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "organizer"
    t.string   "type"
    t.integer  "teams_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "short_name"
    t.string   "long_name"
    t.string   "string"
    t.string   "email"
    t.string   "home_town"
    t.integer  "stadium_id"
    t.string   "mascot"
    t.string   "description"
    t.integer  "club_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams_in_season", :force => true do |t|
    t.string   "picture"
    t.string   "logo"
    t.integer  "team_id"
    t.integer  "season_id"
    t.integer  "contact_information_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams_players", :force => true do |t|
    t.integer  "number"
    t.string   "position"
    t.boolean  "captain"
    t.boolean  "assistant_captain"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password",        :limit => 40
    t.string   "salt",            :limit => 40
    t.integer  "person_id"
    t.boolean  "admin"
    t.boolean  "add_edit_delete"
    t.boolean  "intranet"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

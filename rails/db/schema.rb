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

ActiveRecord::Schema.define(:version => 20100228061827) do

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.date     "founded"
    t.string   "description"
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

  create_table "players", :force => true do |t|
    t.integer  "number"
    t.string   "stick"
    t.string   "position"
    t.integer  "person_id"
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

end

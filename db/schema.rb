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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120319051040) do

  create_table "brains", :force => true do |t|
    t.string   "kind"
    t.string   "size"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guts", :force => true do |t|
    t.string   "kind"
    t.string   "species"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "zombies", :force => true do |t|
    t.string   "name"
    t.string   "gender"
    t.integer  "age"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "brain_id"
    t.integer  "gut_id"
  end

  add_index "zombies", ["brain_id"], :name => "index_zombies_on_brain_id"
  add_index "zombies", ["gut_id"], :name => "index_zombies_on_gut_id"

end

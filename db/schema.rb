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
# It's strongly recommended to check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema.define(:version => 20120420230234) do

  create_table "mercury_images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end
=======
ActiveRecord::Schema.define(:version => 20120420100715) do
>>>>>>> parent of 608bde0... devise init

  create_table "repos", :force => true do |t|
    t.string   "name"
    t.string   "owner"
    t.text     "description"
    t.integer  "watchers"
    t.integer  "forks"
    t.string   "github_url"
    t.string   "homepage"
    t.datetime "last_updated"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.text     "wiki_text",    :default => "Placeholder Wiki-Text"
  end

end

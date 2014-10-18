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

ActiveRecord::Schema.define(version: 20141018121154) do

  create_table "results", force: true do |t|
    t.text     "url"
    t.integer  "load_time"
    t.integer  "ttfb"
    t.integer  "bytes_out"
    t.integer  "bytes_out_doc"
    t.integer  "bytes_in"
    t.integer  "bytes_in_doc"
    t.integer  "requests"
    t.integer  "requests_doc"
    t.integer  "result"
    t.integer  "render"
    t.integer  "fully_loaded"
    t.integer  "cached"
    t.integer  "web"
    t.integer  "doc_time"
    t.integer  "dom_time"
    t.integer  "score_cache"
    t.integer  "score_cdn"
    t.integer  "score_gzip"
    t.integer  "score_cookies"
    t.integer  "score_keep_alive"
    t.integer  "score_minify"
    t.integer  "score_combine"
    t.integer  "score_compress"
    t.integer  "score_etags"
    t.datetime "run_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dom_elements"
  end

  create_table "runs", force: true do |t|
    t.integer  "web_test_id"
    t.integer  "wpt_id"
    t.integer  "first_view_id"
    t.integer  "repeat_view_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "runs", ["web_test_id"], name: "index_runs_on_web_test_id"

  create_table "test_suites", force: true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "web_tests", force: true do |t|
    t.text     "url"
    t.string   "label"
    t.integer  "requested_runs"
    t.string   "location"
    t.text     "additional_parameters"
    t.integer  "status",                default: 0
    t.string   "wpt_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "test_suite_id"
    t.text     "raw_result"
    t.integer  "average_id"
  end

  add_index "web_tests", ["average_id"], name: "index_web_tests_on_average_id"
  add_index "web_tests", ["test_suite_id"], name: "index_web_tests_on_test_suite_id"

end

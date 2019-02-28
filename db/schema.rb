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

ActiveRecord::Schema.define(version: 2019_02_28_131718) do

  create_table "checking_logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "domain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain_id"], name: "index_checking_logs_on_domain_id"
  end

  create_table "domains", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "fqdn", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "expiration_date", null: false
    t.bigint "domain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "certificate_type", default: 0
    t.datetime "notified_at"
    t.integer "status", default: 0
    t.index ["domain_id"], name: "index_notifications_on_domain_id"
    t.index ["status"], name: "index_notifications_on_status"
  end

  add_foreign_key "checking_logs", "domains"
  add_foreign_key "notifications", "domains"
end

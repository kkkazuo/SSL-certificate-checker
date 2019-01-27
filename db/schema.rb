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

ActiveRecord::Schema.define(version: 2019_01_28_160747) do

  create_table "domains", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "fqdn", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "domains_slack_infos", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "slack_info_id", null: false
    t.bigint "domain_id", null: false
    t.index ["slack_info_id", "domain_id"], name: "index_domains_slack_infos_on_slack_info_id_and_domain_id"
  end

  create_table "notification_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.time "notify_before", null: false
    t.bigint "domain_id"
    t.bigint "slack_info_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain_id"], name: "index_notification_infos_on_domain_id"
    t.index ["slack_info_id"], name: "index_notification_infos_on_slack_info_id"
  end

  create_table "slack_channels", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "channel"
    t.bigint "slack_info_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slack_info_id"], name: "index_slack_channels_on_slack_info_id"
  end

  create_table "slack_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "webhook_url", null: false
    t.string "username"
    t.string "encrypted_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "notification_infos", "domains"
  add_foreign_key "notification_infos", "slack_infos"
  add_foreign_key "slack_channels", "slack_infos"
end

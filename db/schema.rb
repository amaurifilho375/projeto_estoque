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

ActiveRecord::Schema.define(version: 2021_07_14_131621) do

  create_table "movimentations", force: :cascade do |t|
    t.string "type", limit: 1
    t.integer "quantities"
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name", limit: 20
    t.integer "movimentation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movimentation_id"], name: "index_products_on_movimentation_id"
  end

  create_table "storages", force: :cascade do |t|
    t.string "name", limit: 20
    t.integer "movimentation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movimentation_id"], name: "index_storages_on_movimentation_id"
  end

  add_foreign_key "products", "movimentations"
  add_foreign_key "storages", "movimentations"
end

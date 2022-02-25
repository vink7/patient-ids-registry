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

ActiveRecord::Schema.define(version: 2022_02_24_101100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "identifications", force: :cascade do |t|
    t.bigint "patient_id"
    t.string "id_number", limit: 50, null: false
    t.string "state_issuer", limit: 50, null: false
    t.string "url", limit: 1024, null: false
    t.datetime "exp_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id_number", "state_issuer"], name: "index_identifications_on_id_number_and_state_issuer", unique: true
    t.index ["patient_id"], name: "index_identifications_on_patient_id", unique: true
  end

  create_table "patients", force: :cascade do |t|
    t.string "first_name", limit: 50, null: false
    t.string "last_name", limit: 50, null: false
    t.string "email", limit: 100, null: false
    t.datetime "dob", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_patients_on_email", unique: true
  end

  create_table "recs", force: :cascade do |t|
    t.bigint "patient_id"
    t.string "rec_number", limit: 50, null: false
    t.string "valid_state", limit: 50, null: false
    t.string "physician_issuer", limit: 50, null: false
    t.string "url", limit: 1024, null: false
    t.datetime "exp_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_recs_on_patient_id", unique: true
    t.index ["rec_number", "physician_issuer"], name: "index_recs_on_rec_number_and_physician_issuer", unique: true
  end

  add_foreign_key "identifications", "patients"
  add_foreign_key "recs", "patients"
end

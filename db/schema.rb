# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_240_303_102_826) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'appointments', force: :cascade do |t|
    t.bigint 'doctor_id', null: false
    t.bigint 'patient_id', null: false
    t.datetime 'scheduled_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['doctor_id'], name: 'index_appointments_on_doctor_id'
    t.index ['patient_id'], name: 'index_appointments_on_patient_id'
  end

  create_table 'doctors', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'indication_id', null: false
    t.index ['indication_id'], name: 'index_doctors_on_indication_id'
  end

  create_table 'indications', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'patients', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'email'
    t.bigint 'doctor_id'
    t.bigint 'indication_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['doctor_id'], name: 'index_patients_on_doctor_id'
    t.index ['indication_id'], name: 'index_patients_on_indication_id'
  end

  add_foreign_key 'appointments', 'doctors'
  add_foreign_key 'appointments', 'patients'
  add_foreign_key 'doctors', 'indications'
  add_foreign_key 'patients', 'doctors'
  add_foreign_key 'patients', 'indications'
end

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

ActiveRecord::Schema[7.1].define(version: 2024_08_07_235352) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fbo_account_statements", force: :cascade do |t|
    t.string "original_filename"
    t.text "file_contents"
    t.bigint "fbo_account_id"
    t.datetime "imported_at"
    t.string "format"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fbo_account_id"], name: "index_fbo_account_statements_on_fbo_account_id"
  end

  create_table "fbo_account_transactions", force: :cascade do |t|
    t.bigint "fbo_account_id"
    t.bigint "fbo_account_statement_id"
    t.date "posted_on"
    t.integer "amount_cents"
    t.string "memo"
    t.integer "index_in_statement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fbo_account_id"], name: "index_fbo_account_transactions_on_fbo_account_id"
    t.index ["fbo_account_statement_id"], name: "index_fbo_account_transactions_on_fbo_account_statement_id"
  end

  create_table "fbo_accounts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

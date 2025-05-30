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

ActiveRecord::Schema[8.0].define(version: 2025_05_26_043911) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "fbo_account_statements", force: :cascade do |t|
    t.string "original_filename"
    t.text "file_contents"
    t.bigint "fbo_account_id", null: false
    t.datetime "imported_at"
    t.string "format"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fbo_account_id"], name: "index_fbo_account_statements_on_fbo_account_id"
  end

  create_table "fbo_account_transactions", force: :cascade do |t|
    t.bigint "fbo_account_id", null: false
    t.bigint "fbo_account_statement_id"
    t.datetime "posted_at"
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
    t.string "bank_account_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monthly_participant_aggregates", force: :cascade do |t|
    t.bigint "te_scheme_participant_id", null: false
    t.integer "year", null: false
    t.integer "month_number", null: false
    t.integer "deposit_total_cents", null: false
    t.integer "demurrage_cents", null: false
    t.integer "te_issue_cents", null: false
    t.integer "te_delta_cents", null: false
    t.integer "te_max_balance_cents", null: false
    t.integer "fbo_funds_added_cents", null: false
    t.string "status", default: "open"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "te_withdrawal_cents", default: 0, null: false
    t.index ["te_scheme_participant_id"], name: "idx_on_te_scheme_participant_id_84833ddf80"
  end

  create_table "monthly_scheme_aggregates", force: :cascade do |t|
    t.bigint "te_scheme_id", null: false
    t.integer "year", null: false
    t.integer "month_number", null: false
    t.integer "te_issue_cents", null: false
    t.integer "te_delta_cents", null: false
    t.integer "te_demurrage_cents", null: false
    t.integer "te_total_cents", null: false
    t.integer "te_total_value_cents", null: false
    t.integer "fbo_funds_added_cents", null: false
    t.integer "fbo_expenditure_cents", null: false
    t.integer "fbo_funds_total_cents", null: false
    t.integer "asset_total_cents", null: false
    t.string "status", default: "open"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "te_withdrawal_cents", default: 0, null: false
    t.index ["te_scheme_id"], name: "index_monthly_scheme_aggregates_on_te_scheme_id"
  end

  create_table "te_scheme_contributions", force: :cascade do |t|
    t.bigint "fbo_account_transaction_id", null: false
    t.bigint "te_scheme_participant_id", null: false
    t.integer "amount_cents", null: false
    t.datetime "received_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fbo_account_transaction_id"], name: "index_te_scheme_contributions_on_fbo_account_transaction_id"
    t.index ["te_scheme_participant_id"], name: "index_te_scheme_contributions_on_te_scheme_participant_id"
  end

  create_table "te_scheme_expenditures", force: :cascade do |t|
    t.bigint "te_scheme_id", null: false
    t.bigint "fbo_account_transaction_id", null: false
    t.integer "amount_cents", null: false
    t.datetime "occured_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fbo_account_transaction_id"], name: "index_te_scheme_expenditures_on_fbo_account_transaction_id"
    t.index ["te_scheme_id"], name: "index_te_scheme_expenditures_on_te_scheme_id"
  end

  create_table "te_scheme_participants", force: :cascade do |t|
    t.bigint "te_scheme_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "closed_on"
    t.index ["te_scheme_id"], name: "index_te_scheme_participants_on_te_scheme_id"
  end

  create_table "te_scheme_withdrawals", force: :cascade do |t|
    t.bigint "te_scheme_participant_id", null: false
    t.bigint "fbo_account_transaction_id", null: false
    t.integer "amount_cents", null: false
    t.datetime "occured_at", null: false
    t.string "reason", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fbo_account_transaction_id"], name: "index_te_scheme_withdrawals_on_fbo_account_transaction_id"
    t.index ["te_scheme_participant_id"], name: "index_te_scheme_withdrawals_on_te_scheme_participant_id"
  end

  create_table "te_schemes", force: :cascade do |t|
    t.string "name"
    t.bigint "fbo_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fbo_account_id"], name: "index_te_schemes_on_fbo_account_id"
  end

  add_foreign_key "fbo_account_statements", "fbo_accounts"
  add_foreign_key "fbo_account_transactions", "fbo_account_statements"
  add_foreign_key "fbo_account_transactions", "fbo_accounts"
  add_foreign_key "monthly_participant_aggregates", "te_scheme_participants"
  add_foreign_key "monthly_scheme_aggregates", "te_schemes"
  add_foreign_key "te_scheme_contributions", "fbo_account_transactions"
  add_foreign_key "te_scheme_contributions", "te_scheme_participants"
  add_foreign_key "te_scheme_expenditures", "fbo_account_transactions"
  add_foreign_key "te_scheme_expenditures", "te_schemes"
  add_foreign_key "te_scheme_participants", "te_schemes"
  add_foreign_key "te_scheme_withdrawals", "fbo_account_transactions"
  add_foreign_key "te_scheme_withdrawals", "te_scheme_participants"
  add_foreign_key "te_schemes", "fbo_accounts"
end

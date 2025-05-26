class CreateTeSchemeWithdrawals < ActiveRecord::Migration[8.0]
  def change
    create_table :te_scheme_withdrawals do |t|
      t.references :te_scheme_participant, null: false, foreign_key: true
      t.references :fbo_account_transaction, null: false, foreign_key: true
      t.integer :amount_cents, null: false
      t.datetime :occured_at, null: false
      t.string :reason, null: false
      t.timestamps
    end
  end
end

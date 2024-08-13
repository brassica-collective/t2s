class CreateTeSchemeExpenditures < ActiveRecord::Migration[7.1]
  def change
    create_table :te_scheme_expenditures do |t|
      t.references :te_scheme, null: false, foreign_key: true
      t.belongs_to :fbo_account_transaction, null: false, foreign_key: true
      t.integer :amount_cents, null: false
      t.datetime :occured_at, null: false
      t.timestamps
    end
  end
end

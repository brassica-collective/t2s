class CreateTeSchemeContributions < ActiveRecord::Migration[7.1]
  def change
    create_table :te_scheme_contributions do |t|
      t.belongs_to :fbo_account_transaction, null: false, foreign_key: true
      t.belongs_to :te_scheme_participant, null: false, foreign_key: true
      t.integer :amount_cents, null: false
      t.integer :fbo_funds_added_cents, null: false
      t.datetime :received_at
      t.timestamps
    end
  end
end

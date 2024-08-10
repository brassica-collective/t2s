class CreateSchemeContributions < ActiveRecord::Migration[7.1]
  def change
    create_table :scheme_contributions do |t|
      t.belongs_to :fbo_account_transaction, null: false, foreign_key: true
      t.belongs_to :te_scheme_participant, null: false, foreign_key: true
      t.integer :amount_cents
      t.datetime :received_at
      t.timestamps
    end
  end
end

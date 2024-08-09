class CreateFboAccountTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :fbo_account_transactions do |t|
      t.belongs_to :fbo_account, null: false, foreign_key: true
      t.belongs_to :fbo_account_statement, null: true, foreign_key: true
      t.datetime :posted_at
      t.integer :amount_cents
      t.string :memo
      t.integer :index_in_statement
      t.timestamps
    end
  end
end

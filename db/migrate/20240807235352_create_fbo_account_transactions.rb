class CreateFboAccountTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :fbo_account_transactions do |t|
      t.belongs_to :fbo_account
      t.belongs_to :fbo_account_statement, null: true
      t.datetime :posted_at
      t.integer :amount_cents
      t.string :memo
      t.integer :index_in_statement
      t.timestamps
    end
  end
end

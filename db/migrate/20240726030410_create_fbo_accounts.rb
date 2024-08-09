class CreateFboAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :fbo_accounts do |t|
      t.string :name
      t.string :bank_account_number
      t.timestamps
    end
  end
end

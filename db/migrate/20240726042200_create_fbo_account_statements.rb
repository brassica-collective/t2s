class CreateFboAccountStatements < ActiveRecord::Migration[7.1]
  def change
    create_table :fbo_account_statements do |t|

      t.timestamps
    end
  end
end

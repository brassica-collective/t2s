class CreateFboAccountStatements < ActiveRecord::Migration[7.1]
  def change
    create_table :fbo_account_statements do |t|
      t.string :original_filename
      t.text :file_contents
      t.timestamps
    end
  end
end

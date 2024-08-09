class CreateFboAccountStatements < ActiveRecord::Migration[7.1]
  def change
    create_table :fbo_account_statements do |t|
      t.string :original_filename
      t.text :file_contents
      t.belongs_to :fbo_account, null: false, foreign_key: true
      t.datetime :imported_at
      t.string :format
      t.timestamps
    end
  end
end

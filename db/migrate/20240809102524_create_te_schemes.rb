class CreateTeSchemes < ActiveRecord::Migration[7.1]
  def change
    create_table :te_schemes do |t|
      t.string :name
      t.belongs_to :fbo_account, null: false, foreign_key: true
      t.timestamps
    end
  end
end

class CreateTeSchemeParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :te_scheme_participants do |t|
      t.belongs_to :te_scheme, null: false, foreign_key: true
      t.string :name
      t.timestamps
    end
  end
end

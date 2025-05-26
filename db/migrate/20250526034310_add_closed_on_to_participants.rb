class AddClosedOnToParticipants < ActiveRecord::Migration[8.0]
  def change
    add_column :te_scheme_participants, :closed_on, :date, null: true
  end
end

class CreateMonthlyParticipantAggregates < ActiveRecord::Migration[7.1]
  def change
    create_table :monthly_participant_aggregates do |t|
      t.belongs_to :te_scheme_participant, null: false, foreign_key: true
      t.integer :year, null: false
      t.integer :month_number, null: false
      t.integer :deposit_total_cents, null: false
      t.integer :demurrage_cents, null: false
      t.integer :te_issue_cents, null: false
      t.integer :te_delta_cents, null: false
      t.integer :te_max_balance_cents, null: false
      t.integer :fbo_funds_added_cents, null: false
      t.string  :status, default: 'open'
      t.timestamps
    end
  end
end

class CreateMonthlyAggregates < ActiveRecord::Migration[7.1]
  def change
    create_table :monthly_aggregates do |t|
      t.belongs_to :te_scheme_participant, null: false, foreign_key: true
      t.integer :year, null: false
      t.integer :day_of_month, null: false
      t.integer :deposit_total_cents, null: false
      t.timestamps
    end
  end
end

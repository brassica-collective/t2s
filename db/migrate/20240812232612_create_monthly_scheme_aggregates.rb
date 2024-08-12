class CreateMonthlySchemeAggregates < ActiveRecord::Migration[7.1]
  def change
    create_table :monthly_scheme_aggregates do |t|
      t.belongs_to :te_scheme, null: false, foreign_key: true
      t.integer :year, null: false
      t.integer :month_number, null: false
      t.integer :te_issue_cents, null: false
      t.integer :te_total_cents, null: false
      t.timestamps
    end
  end
end

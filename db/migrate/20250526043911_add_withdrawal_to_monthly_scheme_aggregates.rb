class AddWithdrawalToMonthlySchemeAggregates < ActiveRecord::Migration[8.0]
  def change
    add_column :monthly_scheme_aggregates, :te_withdrawal_cents, :integer, default: 0, null: false
  end
end

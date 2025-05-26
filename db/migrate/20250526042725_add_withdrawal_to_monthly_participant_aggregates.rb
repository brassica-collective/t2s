class AddWithdrawalToMonthlyParticipantAggregates < ActiveRecord::Migration[8.0]
  def change
    add_column :monthly_participant_aggregates, :te_withdrawal_cents, :integer, null: false, default: 0
  end
end

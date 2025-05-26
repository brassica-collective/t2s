class RemoveFboFundsAddedCentsFromContributions < ActiveRecord::Migration[8.0]
  def change
    remove_column :te_scheme_contributions, :fbo_funds_added_cents, :integer, null: false, default: 0
  end
end

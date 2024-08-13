class MonthlySchemeAggregate < ApplicationRecord
  include HasMonth
  include HasMoney

  money :te_issue
  money :te_delta
  money :te_demurrage
  money :te_total
  money :fbo_funds_added
  money :fbo_funds_total

  belongs_to :te_scheme

  validates :year, presence: true
  validates :month_number, presence: true, uniqueness: { scope: [:te_scheme_id, :year] }

  def previous_aggregate
    te_scheme.monthly_aggregates.before_month(month).date_order.last
  end
end

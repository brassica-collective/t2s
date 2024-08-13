class MonthlySchemeAggregate < ApplicationRecord
  include HasMonth

  composed_of :te_issue, class_name: 'Money', mapping: [ %w(te_issue_cents cents) ]
  composed_of :te_total, class_name: 'Money', mapping: [ %w(te_total_cents cents) ]

  belongs_to :te_scheme

  def previous_aggregate
    te_scheme.monthly_aggregates.before_month(month).date_order.last
  end
end

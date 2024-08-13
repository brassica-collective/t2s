class MonthlySchemeAggregate < ApplicationRecord
  composed_of :month, class_name: 'Month', mapping: [ %w(year year), %w(month_number number) ]
  composed_of :te_issue, class_name: 'Money', mapping: [ %w(te_issue_cents cents) ]
  composed_of :te_total, class_name: 'Money', mapping: [ %w(te_total_cents cents) ]

  belongs_to :te_scheme

  scope :date_order, -> { order(year: :asc, month_number: :asc) }
  scope :before_month, ->(month) { where("year < ? OR (year = ? AND month_number < ?)", month.year, month.year, month.number) }

  def previous_aggregate
    te_scheme.monthly_aggregates.before_month(month).date_order.last
  end
end

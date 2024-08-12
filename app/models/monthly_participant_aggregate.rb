class MonthlyParticipantAggregate < ApplicationRecord
  composed_of :month, class_name: 'Month', mapping: [ %w(year year), %w(month_number number) ]
  composed_of :deposit_total, class_name: 'Money', mapping: [ %w(deposit_total_cents cents) ]
  composed_of :balance, class_name: 'Money', mapping: [ %w(balance_cents cents) ]
  composed_of :demurrage, class_name: 'Money', mapping: [ %w(demurrage_cents cents) ]

  belongs_to :participant, class_name: 'TeSchemeParticipant', foreign_key: :te_scheme_participant_id
  validates :year, presence: true
  validates :month_number, presence: true, uniqueness: { scope: [:te_scheme_participant_id, :year] }
  validates :deposit_total_cents, presence: true

  scope :date_order, -> { order(year: :asc, month_number: :asc) }
  scope :before_month, ->(month) { where("year < ? OR (year = ? AND month_number < ?)", month.year, month.year, month.number) }
  default_scope { date_order }
  scope :for_month, ->(month) { where(year: month.year, month_number: month.number) }

  def previous_aggregate
    participant.monthly_aggregates.before_month(month).date_order.last
  end
end

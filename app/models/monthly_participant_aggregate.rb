class MonthlyParticipantAggregate < ApplicationRecord
  include HasMonth

  composed_of :deposit_total, class_name: 'Money', mapping: [ %w(deposit_total_cents cents) ]
  composed_of :demurrage, class_name: 'Money', mapping: [ %w(demurrage_cents cents) ]
  composed_of :te_issue, class_name: 'Money', mapping: [ %w(te_issue_cents cents) ]
  composed_of :te_balance, class_name: 'Money', mapping: [ %w(te_balance_cents cents) ]

  belongs_to :participant, class_name: 'TeSchemeParticipant', foreign_key: :te_scheme_participant_id
  validates :deposit_total_cents, presence: true

  def previous_aggregate
    participant.monthly_aggregates.before_month(month).date_order.last
  end
end

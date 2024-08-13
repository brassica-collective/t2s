class MonthlyParticipantAggregate < ApplicationRecord
  include HasMonth
  include HasMoney

  money :deposit_total
  money :demurrage
  money :te_issue
  money :te_balance
  money :fbo_funds_added

  belongs_to :participant, class_name: 'TeSchemeParticipant', foreign_key: :te_scheme_participant_id

  validates :deposit_total_cents, presence: true
  validates :year, presence: true
  validates :month_number, presence: true, uniqueness: { scope: [:te_scheme_participant_id, :year] }

  def previous_aggregate
    participant.monthly_aggregates.before_month(month).date_order.last
  end
end

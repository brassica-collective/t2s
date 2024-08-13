class MonthlyParticipantAggregate < ApplicationRecord
  include HasMonth
  include HasMoney

  money :deposit_total
  money :demurrage
  money :te_issue
  money :te_delta
  money :te_max_balance
  money :fbo_funds_added

  belongs_to :participant, class_name: 'TeSchemeParticipant', foreign_key: :te_scheme_participant_id

  validates :deposit_total_cents, presence: true
  validates :year, presence: true
  validates :month_number, presence: true, uniqueness: { scope: [:te_scheme_participant_id, :year] }

  def previous_aggregate
    participant.monthly_aggregates.before_month(month).date_order.last
  end

  def te_value(scheme_aggregate = nil)
    scheme_aggregate ||= scheme.monthly_aggregates.for_month(month).first
    return Money.new(0) unless scheme_aggregate

    scheme_aggregate.te_value_ratio * te_max_balance
  end

  private

  def scheme
    participant.te_scheme
  end
end

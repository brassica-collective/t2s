class MonthlyAggregate < ApplicationRecord
  composed_of :month, class_name: 'Month', mapping: [ %w(year year), %w(month_number number) ]

  belongs_to :participant, class_name: 'TeSchemeParticipant', foreign_key: :te_scheme_participant_id
  validates :year, presence: true
  validates :month_number, presence: true, uniqueness: { scope: [:te_scheme_participant_id, :year] }
  validates :deposit_total_cents, presence: true

  def deposit_total
    Money.from_cents(deposit_total_cents, "AUD")
  end
end

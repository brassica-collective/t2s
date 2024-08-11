class MonthlyAggregates < ApplicationRecord
  belongs_to :participant, class_name: 'TeSchemeParticipant', foreign_key: :te_scheme_participant_id
  validates :month, presence: true, uniqueness: { scope: :te_scheme_participant_id }

  def month
    Month.new(year, day_of_month)
  end
end

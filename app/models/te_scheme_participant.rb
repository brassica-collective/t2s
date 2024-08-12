class TeSchemeParticipant < ApplicationRecord
  belongs_to :te_scheme
  has_many :contributions, class_name: 'TeSchemeContribution'
  has_many :monthly_aggregates, class_name: 'MonthlyParticipantAggregate'

  validates :name, presence: true

  def first_month
    first_date = contributions.minimum(:received_at)
    first_date.nil? ? Month.now : Month(first_date)
  end
end

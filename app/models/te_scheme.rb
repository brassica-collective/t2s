class TeScheme < ApplicationRecord
  belongs_to :fbo_account
  has_many :participants, class_name: 'TeSchemeParticipant'
  has_many :contributions, class_name: 'TeSchemeContribution', through: :participants
  has_many :monthly_aggregates, class_name: 'MonthlySchemeAggregate'
  has_many :monthly_participant_aggregates, class_name: 'MonthlyParticipantAggregate', through: :participants, source: :monthly_aggregates

  def first_month
    first_date = contributions.minimum(:received_at)
    first_date.nil? ? Month.now : Month(first_date)
  end
end

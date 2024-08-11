class TeSchemeParticipant < ApplicationRecord
  belongs_to :te_scheme
  has_many :contributions, class_name: 'TeSchemeContribution'
  has_many :monthly_aggregates

  validates :name, presence: true
end

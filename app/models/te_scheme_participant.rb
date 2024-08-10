class TeSchemeParticipant < ApplicationRecord
  belongs_to :te_scheme
  has_many :contributions, class_name: 'TeSchemeContribution'

  validates :name, presence: true
end

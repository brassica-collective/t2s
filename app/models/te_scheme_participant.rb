class TeSchemeParticipant < ApplicationRecord
  belongs_to :te_scheme

  validates :name, presence: true
end

class TeScheme < ApplicationRecord
  belongs_to :fbo_account
  has_many :participants, class_name: 'TeSchemeParticipant'
  has_many :contributions, class_name: 'TeSchemeContribution', through: :participants
end

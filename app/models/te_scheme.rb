class TeScheme < ApplicationRecord
  belongs_to :fbo_account
  has_many :participants, class_name: 'TeSchemeParticipant'
end

class SchemeContribution < ApplicationRecord
  belongs_to :participant, class_name: 'TeSchemeParticipant', foreign_key: 'te_scheme_participant_id'
  belongs_to :fbo_account_transaction

  validates :amount_cents, presence: true
  validates :received_at, presence: true
end

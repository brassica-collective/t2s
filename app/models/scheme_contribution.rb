class SchemeContribution < ApplicationRecord
  belongs_to :scheme_participant, class_name: 'TeSchemeParticipant'
  belongs_to :fbo_account_transaction

  validates :amount_cents, presence: true
  validates :received_at, presence: true
end

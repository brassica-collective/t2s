class TeSchemeContribution < ApplicationRecord
  belongs_to :participant, class_name: 'TeSchemeParticipant', foreign_key: 'te_scheme_participant_id'
  belongs_to :fbo_account_transaction

  validates :amount_cents, presence: true
  validates :received_at, presence: true

  scope :for_month, ->(month) { where(received_at: month.dates) }

  def amount
    Money.from_cents(amount_cents, "AUD")
  end
end

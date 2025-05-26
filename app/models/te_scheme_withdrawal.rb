class TeSchemeWithdrawal < ApplicationRecord
  include HasMoney

  money :amount
  money :fbo_funds_added

  belongs_to :participant, class_name: 'TeSchemeParticipant', foreign_key: 'te_scheme_participant_id'
  belongs_to :fbo_account_transaction

  validates :amount_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :occured_at, presence: true
  validates :reason, presence: true, length: { maximum: 255 }

  scope :for_month, ->(month) { where(occured_at: month.dates) }
end

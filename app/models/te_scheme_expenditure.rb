class TeSchemeExpenditure < ApplicationRecord
  include HasMoney

  belongs_to :te_scheme
  belongs_to :fbo_account_transaction

  money :amount

  validates :fbo_account_transaction, presence: true, uniqueness: { scope: :te_scheme }
  validates :amount, presence: true, numericality: { greater_than: 0 }

  scope :for_fbo_transaction, ->(fbo_transaction) { where(fbo_account_transaction: fbo_transaction) }
  scope :for_month, ->(month) { where(occured_at: month.dates) }
end

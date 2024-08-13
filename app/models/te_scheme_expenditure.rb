class TeSchemeExpenditure < ApplicationRecord
  include HasMoney

  belongs_to :te_scheme
  belongs_to :fbo_account_transaction

  money :amount

  validates :fbo_account_transaction, presence: true, uniqueness: { scope: :te_scheme }
end

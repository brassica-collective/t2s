class FboAccountTransaction < ApplicationRecord
  belongs_to :fbo_account_statement
  belongs_to :fbo_account
  has_one :te_scheme_contribution
  has_one :te_scheme_expenditure

  def amount
    Money.from_cents(amount_cents, "AUD")
  end

  def money_in?
    amount_cents > 0
  end

  def money_out?
    amount_cents < 0
  end
end

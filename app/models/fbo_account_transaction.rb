class FboAccountTransaction < ApplicationRecord
  belongs_to :fbo_account_statement
  belongs_to :fbo_account

  def amount
    Money.from_cents(amount_cents, "AUD")
  end
end

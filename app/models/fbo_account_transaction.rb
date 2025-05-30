class FboAccountTransaction < ApplicationRecord
  belongs_to :fbo_account_statement
  belongs_to :fbo_account
  has_one :te_scheme_contribution, dependent: :destroy
  has_one :te_scheme_expenditure, dependent: :destroy
  has_one :te_scheme_withdrawal, dependent: :destroy

  scope :date_order, -> { order(:posted_at) }

  def amount
    Money.from_cents(amount_cents, "AUD")
  end

  def money_in?
    amount_cents > 0
  end

  def money_out?
    amount_cents < 0
  end

  def reconciled?
    te_scheme_contribution.present? || te_scheme_expenditure.present? || te_scheme_withdrawal.present?
  end
end

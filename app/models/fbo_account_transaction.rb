class FboAccountTransaction < ApplicationRecord
  belongs_to :fbo_account_statement
  belongs_to :fbo_account

  def amount
    Money.from_cents(amount_cents, "AUD")
  end

  def money_in?
    amount_cents > 0
  end

  def money_out?
    amount_cents < 0
  end

  def assign_to_participant!(participant)
    raise "Assigning to participant: #{participant.inspect}"
    # update!(participant: participant)
  end
end

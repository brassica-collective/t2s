class Contributions::IndividualContributionService
  def assign_fbo_transaction(fbo_transaction, participant)
    existing = find_existing_contribution(fbo_transaction)
    if existing
      raise "Transaction already assigned to participant: #{existing.inspect}"
    else
      create_contribution(fbo_transaction, participant)
    end

  end

  private

  def find_existing_contribution(fbo_transaction)
    fbo_transaction.scheme_contribution
  end

  def create_contribution(fbo_transaction, participant)
    SchemeContribution.create!(
      fbo_account_transaction: fbo_transaction,
      participant: participant,
      amount_cents: fbo_transaction.amount_cents,
      received_at: fbo_transaction.posted_at
    )
  end
end

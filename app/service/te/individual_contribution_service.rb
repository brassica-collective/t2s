class Te::IndividualContributionService
  def initialize(aggregate_service = Te::ContributionAggregateService.new)
    @aggregate_service = aggregate_service
  end

  def assign_fbo_transaction(fbo_transaction, participant)
    check_isnt_assigned!(fbo_transaction)

    contribution = create_contribution(fbo_transaction, participant)
    aggregate_service.aggregate(participant, Month(contribution.received_at))
  end

  def withdraw_fbo_transaction(fbo_transaction, participant, reason)
    check_isnt_assigned!(fbo_transaction)

    withdrawal = create_withdrawal(fbo_transaction, participant, reason)
    aggregate_service.aggregate(participant, Month(withdrawal.occured_at))
  end

  private

  attr_reader :aggregate_service

  def check_isnt_assigned!(fbo_transaction)
    existing_contribution = find_existing_contribution(fbo_transaction)
    raise "Transaction already assigned to participant: #{existing_contribution.inspect}" if existing_contribution

    existing_withrawal = find_existing_withdrawal(fbo_transaction)
    raise "Transaction already withdrawn: #{existing_withrawal.inspect}" if existing_withrawal
  end

  def find_existing_contribution(fbo_transaction)
    fbo_transaction.te_scheme_contribution
  end

  def find_existing_withdrawal(fbo_transaction)
    fbo_transaction.te_scheme_withdrawal
  end

  def create_contribution(fbo_transaction, participant)
    TeSchemeContribution.create!(
      fbo_account_transaction: fbo_transaction,
      participant: participant,
      amount_cents: fbo_transaction.amount_cents,
      received_at: fbo_transaction.posted_at
    )
  end

  def create_withdrawal(fbo_transaction, participant, reason)
    TeSchemeWithdrawal.create!(
      fbo_account_transaction: fbo_transaction,
      participant: participant,
      amount_cents: fbo_transaction.amount_cents,
      occured_at: fbo_transaction.posted_at,
      reason: reason
    )
  end
end

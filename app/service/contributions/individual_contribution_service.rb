class Contributions::IndividualContributionService
  def initialize(aggregate_service = MonthlyAggregateService.new)
    @aggregate_service = aggregate_service
  end

  def assign_fbo_transaction(fbo_transaction, participant)
    existing = find_existing_contribution(fbo_transaction)
    if existing
      raise "Transaction already assigned to participant: #{existing.inspect}"
    else
      contribution = create_contribution(fbo_transaction, participant)
      aggregate_service.aggregate(participant, Month(contribution.received_at))
    end

  end

  private

  attr_reader :aggregate_service

  def find_existing_contribution(fbo_transaction)
    fbo_transaction.te_scheme_contribution
  end

  def create_contribution(fbo_transaction, participant)
    TeSchemeContribution.create!(
      fbo_account_transaction: fbo_transaction,
      participant: participant,
      amount_cents: fbo_transaction.amount_cents,
      received_at: fbo_transaction.posted_at
    )
  end
end

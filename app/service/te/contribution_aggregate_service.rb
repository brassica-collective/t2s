class Te::ContributionAggregateService
  def aggregate_all(scheme)
    scheme.participants.each do |participant|
      aggregate(participant, participant.first_month)
    end
  end

  def aggregate(participant, month)
    existing = find_existing(participant, month)
    if existing
      update_aggregate(participant, month, existing)
    else
      create_aggregate(participant, month)
    end
    aggregate_if_necessary(participant, month.next)
  end

  def aggregate_if_necessary(participant, month)
    return unless month <= Month.now
    aggregate(participant, month)
  end

  private

  def find_existing(participant, month)
    participant.monthly_aggregates.find_by(year: month.year, month_number: month.number)
  end

  def create_aggregate(participant, month)
    aggregate = participant.monthly_aggregates.build(year: month.year, month_number: month.number)
    update_aggregate(participant, month, aggregate)
  end

  def update_aggregate(participant, month, aggregate)
    previous_aggregate = aggregate.previous_aggregate

    aggregate.deposit_total = compute_deposit_total(participant, month)
    aggregate.te_withdrawal = compute_withdrawal_total(participant, month)
    aggregate.demurrage = compute_demurrage(previous_aggregate, aggregate.te_withdrawal)
    aggregate.te_issue = aggregate.deposit_total
    aggregate.te_delta = aggregate.te_issue - aggregate.te_withdrawal - aggregate.demurrage
    aggregate.te_max_balance = compute_te_max_balance(aggregate, previous_aggregate)
    aggregate.fbo_funds_added = aggregate.deposit_total
    aggregate.status = month < Month.now ? 'closed' : 'open'





    aggregate.save!
  end

  def compute_deposit_total(participant, month)
    Money.new(participant.contributions.for_month(month).sum(:amount_cents))
  end

  def compute_withdrawal_total(participant, month)
    Money.new(participant.withdrawals.for_month(month).sum(:amount_cents))
  end

  def compute_te_max_balance(aggregate, previous_aggregate)
    previous_te_max_balance(previous_aggregate) + aggregate.te_delta
  end

  def compute_demurrage(previous_aggregate, current_withdrawal)
    balance_for_demurrage = previous_te_max_balance(previous_aggregate) - current_withdrawal
    return Money.new(0) if balance_for_demurrage <= Money.new(0)

    balance_for_demurrage * monthy_demurrage_rate
  end

  def monthy_demurrage_rate
    yearly_demurrage_rate / 12
  end

  def yearly_demurrage_rate
    0.02
  end

  def previous_te_max_balance(previous_aggregate)
    previous_aggregate&.te_max_balance || Money.new(0)
  end
end

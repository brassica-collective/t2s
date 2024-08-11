class Contributions::MonthlyAggregateService
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
    aggregate.balance = compute_balance(aggregate, previous_aggregate)
    aggregate.demurrage = Money.new(0)
    aggregate.save!
  end

  def compute_deposit_total(participant, month)
    Money.new(participant.contributions.for_month(month).sum(:amount_cents))
  end

  def compute_balance(aggregate, previous_aggregate)
    previous_balance(previous_aggregate) + aggregate.deposit_total
  end

  def previous_balance(previous_aggregate)
    previous_aggregate&.balance || Money.new(0)
  end
end

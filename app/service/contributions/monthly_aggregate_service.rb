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
    aggregate.deposit_total_cents = compute_deposit_total(participant, month)
    aggregate.save!
  end

  def compute_deposit_total(participant, month)
    participant.contributions.for_month(month).sum(:amount_cents)
  end
end

class Contributions::MonthlyAggregateService
  def aggregate(participant, month)
    existing = find_existing(participant, month)
    if existing
      raise "aggregate already exists for #{participant.id} #{month}"
    else
      create_aggregate(participant, month)
    end
  end

  private

  def find_existing(participant, month)
    participant.monthly_aggregates.find_by(year: month.year, month_number: month.number)
  end

  def create_aggregate(participant, month)
    result = participant.monthly_aggregates.build(year: month.year, month_number: month.number)
    result.deposit_total_cents = compute_deposit_total(participant, month)
    result.save!
  end

  def compute_deposit_total(participant, month)
    participant.contributions.for_month(month).sum(:amount_cents)
  end
end

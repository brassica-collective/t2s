class Te::SchemeAggregateService
  def initialize
    @contribution_aggregate_service = Te::ContributionAggregateService.new
  end

  def aggregate_participants_and_scheme(scheme)
    contribution_aggregate_service.aggregate_all(scheme)
    aggregate_scheme(scheme)
  end

  def aggregate_scheme(scheme, month = nil)
    month ||= scheme.first_month

    existing = find_existing(scheme, month)
    if existing
      update_aggregate(scheme, month, existing)
    else
      create_aggregate(scheme, month)
    end
  end

  private

  attr_reader :contribution_aggregate_service

  def find_existing(scheme, month)
    scope(scheme, month).first
  end

  def update_aggregate(scheme, month, existing)
    raise "update aggregate not implemented"
  end

  def create_aggregate(scheme, month)
    aggregate = scope(scheme, month).build
    update_aggregate(scheme, month, aggregate)

  end

  def update_aggregate(scheme, month, aggregate)
    participant_aggregates = scheme.monthly_participant_aggregates.for_month(month).all

    aggregate.te_issue = compute_te_issue(scheme, month, participant_aggregates)
    aggregate.te_total = compute_te_total(scheme, month, participant_aggregates)
    aggregate.save!
  end

  def scope(scheme, month)
    scheme.monthly_aggregates.where(year: month.year, month_number: month.number)
  end

  def compute_te_issue(scheme, month, participant_aggregates)

    raise "compute te issue not implemented"
  end

  def compute_te_total(scheme, month, participant_aggregates)
    raise "compute te total not implemented"
  end
end

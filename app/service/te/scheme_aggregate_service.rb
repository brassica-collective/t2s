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
    aggregate_scheme_if_necessary(scheme, month.next)
  end

  def aggregate_scheme_if_necessary(scheme, month)
    return unless month <= Month.now
    aggregate_scheme(scheme, month)
  end

  private

  attr_reader :contribution_aggregate_service

  def find_existing(scheme, month)
    scope(scheme, month).first
  end

  def create_aggregate(scheme, month)
    aggregate = scope(scheme, month).build
    update_aggregate(scheme, month, aggregate)
  end

  def update_aggregate(scheme, month, aggregate)
    participant_aggregates = scheme.monthly_participant_aggregates.for_month(month).all
    previous_aggregate = aggregate.previous_aggregate

    aggregate.te_issue = compute_te_issue(participant_aggregates)
    aggregate.te_delta = compute_te_delta(participant_aggregates)
    aggregate.te_demurrage = compute_te_demurrage(participant_aggregates)
    aggregate.te_total = compute_te_total(aggregate, previous_aggregate)
    aggregate.fbo_funds_added = compute_fbo_funds_added(participant_aggregates)
    aggregate.fbo_funds_total = compute_fbo_funds_total(aggregate, previous_aggregate)
    aggregate.save!
  end

  def scope(scheme, month)
    scheme.monthly_aggregates.where(year: month.year, month_number: month.number)
  end

  def compute_te_issue(participant_aggregates)
    participant_aggregates.map(&:te_issue).sum
  end

  def compute_te_demurrage(participant_aggregates)
    participant_aggregates.map(&:demurrage).sum
  end

  def compute_te_delta(participant_aggregates)
    participant_aggregates.map(&:te_delta).sum
  end

  def compute_te_total(aggregate, previous_aggregate)
    (previous_aggregate&.te_delta || Money.new(0)) + aggregate.te_delta
  end

  def compute_fbo_funds_added(participant_aggregates)
    participant_aggregates.map(&:fbo_funds_added).sum
  end

  def compute_fbo_funds_total(aggregate, previous_aggregate)
    (previous_aggregate&.fbo_funds_added || Money.new(0)) + aggregate.fbo_funds_added
  end
end

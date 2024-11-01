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
    aggregate.fbo_expenditure = compute_fbo_expenditure_total(scheme, month)
    aggregate.fbo_funds_total = compute_fbo_funds_total(aggregate, previous_aggregate)
    aggregate.asset_total = compute_asset_total(aggregate)
    aggregate.te_total_value = compute_te_total_value(aggregate)
    aggregate.status = month < Month.now ? 'closed' : 'open'
    aggregate.save!
  end

  def scope(scheme, month)
    scheme.monthly_aggregates.where(year: month.year, month_number: month.number)
  end

  def compute_te_issue(participant_aggregates)
    sum_money participant_aggregates.map(&:te_issue)
  end

  def compute_te_demurrage(participant_aggregates)
    sum_money participant_aggregates.map(&:demurrage)
  end

  def compute_te_delta(participant_aggregates)
    sum_money participant_aggregates.map(&:te_delta)
  end

  def compute_te_total(aggregate, previous_aggregate)
    (previous_aggregate&.te_total || Money.new(0)) + aggregate.te_delta
  end

  def compute_fbo_funds_added(participant_aggregates)
    sum_money participant_aggregates.map(&:fbo_funds_added)
  end

  def compute_fbo_funds_total(aggregate, previous_aggregate)
    (previous_aggregate&.fbo_funds_total || Money.new(0)) + aggregate.fbo_funds_added - aggregate.fbo_expenditure
  end

  def compute_fbo_expenditure_total(scheme, month)
    sum_money scheme.expenditures.for_month(month).map(&:amount)
  end

  def sum_money(collection)
    Money::Collection.new(collection).sum
  end

  def compute_asset_total(aggregate)
    aggregate.fbo_funds_total # + real estate total value
  end

  def compute_te_total_value(aggregate)
    [aggregate.te_total, aggregate.asset_total].min
  end
end
